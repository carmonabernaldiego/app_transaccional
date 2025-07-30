import 'package:flutter/material.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../core/network/api_client.dart';
import '../../domain/models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepositoryImpl _repo = UserRepositoryImpl(ApiClient());

  bool isLoading = false;
  String? error;
  UserModel? user;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await _repo.login(email, password);
      isLoading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
