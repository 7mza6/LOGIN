import '../models/userModel.dart';

abstract class userRepository {
  Future<user?> readUser(String username);
  Future<int> update(user _user);
  Future<user> create(user _user);
  Future<int> delete(int id);
  Future<List<user>> readAll();
  Future<int> updatePassword(user _user, String newPassword);
}
