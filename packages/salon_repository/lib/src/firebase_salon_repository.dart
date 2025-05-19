import 'dart:io';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:salon_repository/salon_repository.dart';

class FirebaseSalonRepository implements SalonRepository {
  FirebaseSalonRepository();

  final salonCollection = FirebaseFirestore.instance.collection('salons');

  @override
  Future<List<Salon>> getSalons({
    int? limit,
    String? lastSalonId,
    bool? isFreelancer,
    List<String>? services,
    double? minRating,
  }) async {
    try {
      Query query = salonCollection;

      // apply [isFreelancer] filter if provided, otherwise default to [false] or (salons)
      if (isFreelancer != null) {
        query = query.where('isFreelancer', isEqualTo: isFreelancer);
      } else {
        query = query.where('isFreelancer', isEqualTo: false);
      }

      // apply pagination if lastSalonId is provided
      if (lastSalonId != null) {
        final lastDocumentSnapshot =
            await salonCollection.doc(lastSalonId).get();
        if (lastDocumentSnapshot.exists) {
          query = query.startAfterDocument(lastDocumentSnapshot);
        }
      }

      // apply [limit] filter if provided
      if (limit != null) {
        query = query.limit(limit);
      }

      final querySnapshot = await query.get();

      List<Salon> salons = querySnapshot.docs
          .map(
            (doc) => Salon.fromEntity(
                SalonEntity.fromDocument(doc.data() as Map<String, dynamic>)),
          )
          .toList();

      // client-side filtering for [services] and [minRating]
      if (services != null && services.isNotEmpty) {
        salons = salons.where((salon) {
          return salon.services.any((service) => services.contains(service));
        }).toList();
      }

      if (minRating != null) {
        salons = salons
            .where(
              (element) => element.rating >= minRating,
            )
            .toList();
      }

      return salons;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Salon>> getFreelancers() async {
    try {
      final querySnapshot =
          await salonCollection.where('isFreelancer', isEqualTo: true).get();

      return querySnapshot.docs
          .map((doc) => Salon.fromEntity(SalonEntity.fromDocument(doc.data())))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Salon> getSalonById(String salonId) async {
    try {
      final docSnapshot = await salonCollection.doc(salonId).get();

      if (!docSnapshot.exists) {
        throw Exception('Salon not found');
      }

      return Salon.fromEntity(SalonEntity.fromDocument(docSnapshot.data()!));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setSalonData(Salon salon) async {
    try {
      await salonCollection.doc(salon.id).set(salon.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadSalonPicture(String file, String salonId) async {
    try {
      File imageFile = File(file);
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('salons/$salonId/profilePicture/${salonId}_lead');

      await firebaseStorageRef.putFile(imageFile);
      String url = await firebaseStorageRef.getDownloadURL();

      await salonCollection.doc(salonId).update({
        'picture': url,
      });

      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Salon>> searchSalons(String query) async {
    try {
      // This is a simple implementation. For production, consider using
      // Firebase extensions like Algolia or ElasticSearch for better search
      final querySnapshot = await salonCollection.get();

      final allSalons = querySnapshot.docs
          .map((doc) => Salon.fromEntity(SalonEntity.fromDocument(doc.data())))
          .toList();

      // Filter salons based on query
      return allSalons
          .where((salon) =>
              salon.name.toLowerCase().contains(query.toLowerCase()) ||
              salon.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<Salon>> getSalonsStream() {
    return salonCollection
        .where('isFreelancer', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Salon.fromEntity(SalonEntity.fromDocument(doc.data())))
          .toList();
    });
  }

  @override
  Stream<List<Salon>> getFreelancersStream() {
    return salonCollection
        .where('isFreelancer', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Salon.fromEntity(SalonEntity.fromDocument(doc.data())))
          .toList();
    });
  }
}
