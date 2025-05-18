import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:salon_repository/src/entities/entities.dart';

class Salon extends Equatable {
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
  String? picture;
  final bool isFreelancer;
  final GeoPoint? location;

  Salon({
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

  // empty salon representing no salon selected
  static final emptySalon = Salon(
    id: '',
    name: '',
    address: '',
    phone: '',
    email: '',
    description: '',
    services: [],
    stylists: [],
    rating: 0.0,
    reviewCount: 0,
    picture: '',
    isFreelancer: false,
  );

  // modify Salon parameters
  Salon copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    String? description,
    List<String>? services,
    List<String>? stylists,
    double? rating,
    int? reviewCount,
    String? picture,
    bool? isFreelancer,
    GeoPoint? location,
  }) {
    return Salon(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      description: description ?? this.description,
      services: services ?? this.services,
      stylists: stylists ?? this.stylists,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      picture: picture ?? this.picture,
      isFreelancer: isFreelancer ?? this.isFreelancer,
      location: location ?? this.location,
    );
  }

  // convenience getters for when verifying if salon object is empty or not
  bool get isEmpty => this == Salon.emptySalon;
  bool get isNotEmpty => this != Salon.emptySalon;

  SalonEntity toEntity() {
    return SalonEntity(
      id: id,
      name: name,
      address: address,
      phone: phone,
      email: email,
      description: description,
      services: services,
      stylists: stylists,
      rating: rating,
      reviewCount: reviewCount,
      picture: picture,
      isFreelancer: isFreelancer,
      location: location,
    );
  }

  static Salon fromEntity(SalonEntity entity) {
    return Salon(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      phone: entity.phone,
      email: entity.email,
      description: entity.description,
      services: entity.services,
      stylists: entity.stylists,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      picture: entity.picture,
      isFreelancer: entity.isFreelancer,
      location: entity.location,
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
}
