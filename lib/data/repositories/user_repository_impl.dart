import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl(this.apiClient);

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiClient.post('/user/auth/login', data: {
        "email": email,
        "password": password,
      });
      if (response.data['data'] != null) {
        final userJson = response.data['data']['user'];
        return UserModel.fromJson(userJson);
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al iniciar sesión');
    }
  }

  @override
  Future<UserModel?> register(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.post('/user/auth/register', data: data);
      if (response.data != null && response.data['data'] != null) {
        return UserModel.fromJson(response.data['data']['user'] ?? response.data['data']);
      }
      if (response.data != null && response.data['success'] == true) {
        return null;
      }
      throw Exception(response.data?['message'] ?? 'Error desconocido al registrar');
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al registrar usuario');
    }
  }
}
