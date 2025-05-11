import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_service_management/presentation/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildUsernameField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.login,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() => TextFormField(
        controller: controller.usernameController,
        decoration: const InputDecoration(labelText: 'Username'),
        validator: controller.validateNotEmpty,
      );

  Widget _buildPasswordField() => TextFormField(
        controller: controller.passwordController,
        obscureText: true,
        decoration: const InputDecoration(labelText: 'Password'),
        validator: controller.validateNotEmpty,
      );
}
