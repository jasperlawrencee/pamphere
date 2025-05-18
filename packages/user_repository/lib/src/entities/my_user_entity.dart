import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String password;
  final int history;
  final int favorites;
  final int reviews;
  final String? picture;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.history,
    required this.favorites,
    required this.reviews,
    required this.picture,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'history': history,
      'favorites': favorites,
      'reviews': reviews,
      'picture': picture,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      password: doc['password'] as String,
      history: doc['history'] as int,
      favorites: doc['favorites'] as int,
      reviews: doc['reviews'] as int,
      picture: doc['picture'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        picture,
        password,
        history,
        favorites,
        reviews,
      ];

  @override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
      password: $password
      history: $history
      favorites: $favorites
      reviews: $reviews
      picture: $picture
    }''';
  }
}
