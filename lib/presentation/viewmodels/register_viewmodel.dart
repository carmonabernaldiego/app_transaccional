import 'package:flutter/material.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../core/network/api_client.dart';
import '../../domain/models/user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserRepositoryImpl _repo = UserRepositoryImpl(ApiClient());

  bool isLoading = false;
  String? error;
  UserModel? user;

  Future<bool> register(Map<String, dynamic> data) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final user = await _repo.register(data);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString().replaceAll('Exception: ', '');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
