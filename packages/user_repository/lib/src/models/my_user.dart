import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.picture,
  });

  // empty user representing no user logged in
  static const emptyUser = MyUser(
    id: '',
    email: '',
    name: '',
    picture: '',
  );

  // modify MyUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  // convenience getters for when verifying if user object is empty or not
  // empty
  bool get isEmpty => this == MyUser.emptyUser;
  // not empty
  bool get isNotEmpty => this != MyUser.emptyUser;

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
      picture: picture,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture];
}
