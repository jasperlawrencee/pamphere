import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SalonEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String description;
  final List<String> services;
  final List<String> stylists;
  final double rating;
  final int reviewCount;
  final String? picture;
  final bool isFreelancer;
  final GeoPoint? location;

  const SalonEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
    required this.services,
    required this.stylists,
    required this.rating,
    required this.reviewCount,
    this.picture,
    required this.isFreelancer,
    this.location,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'description': description,
      'services': services,
      'stylists': stylists,
      'rating': rating,
      'reviewCount': reviewCount,
      'picture': picture,
      'isFreelancer': isFreelancer,
      'location': location,
    };
  }

  static SalonEntity fromDocument(Map<String, dynamic> doc) {
    return SalonEntity(
      id: doc['id'] as String,
      name: doc['name'] as String,
      address: doc['address'] as String,
      phone: doc['phone'] as String,
      email: doc['email'] as String,
      description: doc['description'] as String,
      services: List<String>.from(doc['services'] as List),
      stylists: List<String>.from(doc['stylists'] as List),
      rating: doc['rating'] as double,
      reviewCount: doc['reviewCount'] as int,
      picture: doc['picture'] as String?,
      isFreelancer: doc['isFreelancer'] as bool,
      location: doc['location'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        phone,
        email,
        description,
        services,
        stylists,
        rating,
        reviewCount,
        picture,
        isFreelancer,
        location,
      ];

  @override
  String toString() {
    return '''SalonEntity: {
      id: $id
      name: $name
      address: $address
      phone: $phone
      email: $email
      description: $description
      services: $services
      stylists: $stylists
      rating: $rating
      reviewCount: $reviewCount
      picture: $picture
      isFreelancer: $isFreelancer
      location: $location
    }''';
  }
}
