import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'presentation/controllers/login_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loginController = Get.put(LoginController());
  final isLoggedIn = await loginController.checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mini Service Booking',
      initialRoute: isLoggedIn ? AppRoutes.services : AppRoutes.login,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
