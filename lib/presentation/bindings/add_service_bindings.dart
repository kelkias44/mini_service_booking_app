import 'package:get/get.dart';
import '../../data/repositories/service_repository_impl.dart';
import '../../domain/repositories/service_repository.dart';
import '../../domain/usecases/add_service.dart';
import '../controllers/add_edit_controller.dart';

class AddServiceBinding implements Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ServiceRepository>()) {
      Get.lazyPut<ServiceRepository>(() => ServiceRepositoryImpl(
            remoteDataSource: Get.find(),
          ));
    }

    Get.lazyPut<AddService>(
      () => AddService(Get.find<ServiceRepository>()),
    );

    Get.lazyPut<AddServiceController>(
      () => AddServiceController(addService: Get.find()),
    );
  }
}
