import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String password;
  String? picture;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    this.picture,
  });

  // empty user representing no user logged in
  static final emptyUser = MyUser(
    id: '',
    email: '',
    name: '',
    password: '',
    picture: '',
  );

  // modify MyUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
    String? picture,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
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
      password: password,
      picture: picture,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      password: entity.password,
      picture: entity.picture,
    );
  }

  @override
  List<Object?> get props => [id, email, name, password, picture];
}
