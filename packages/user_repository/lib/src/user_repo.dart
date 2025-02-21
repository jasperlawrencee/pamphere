import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<void> signIn(String email, String password);

  Future<void> logout();

  Future<MyUser> signUp(MyUser user, String password);

  Future<void> resetPassword(String email);

  Future<void> setUserData(MyUser myUser);

  Future<MyUser> getMyUser(String myUserId);

  Future<String> uploadPicutre(String file, String userId);
}
