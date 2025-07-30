import '../models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> login(String email, String password);
  Future<UserModel?> register(Map<String, dynamic> data);
}
