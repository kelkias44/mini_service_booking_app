import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    Get.offAllNamed('/services');
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }

  String? validateNotEmpty(String? value) =>
      value?.isEmpty ?? true ? 'This field is required' : null;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
