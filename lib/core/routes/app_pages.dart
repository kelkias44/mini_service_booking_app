import 'package:get/get.dart';
import 'package:simple_service_management/presentation/pages/service_detail_page.dart';
import '../../presentation/bindings/add_service_bindings.dart';
import '../../presentation/bindings/service_bindings.dart';
import '../../presentation/bindings/update_service_bindings.dart';
import '../../presentation/pages/add_edit_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/service_page.dart';
import '../../presentation/pages/update_service_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(
      name: AppRoutes.services,
      page: () => ServicesPage(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: AppRoutes.addService,
      page: () => AddServicePage(),
      binding: AddServiceBinding(),
    ),
    GetPage(
      name: AppRoutes.updateService,
      page: () => UpdateServicePage(),
      binding: UpdateServiceBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceDetail,
      page: () => ServiceDetailPage(service: Get.arguments),
    )
  ];
}
