import 'package:get/get.dart';
import '../../domain/entities/service.dart';
import '../../domain/usecases/update_service.dart';
import '../controllers/update_service_controller.dart';

class UpdateServiceBinding implements Bindings {
  @override
  void dependencies() {
    final Service service = Get.arguments;

    Get.lazyPut<UpdateServiceController>(
      () => UpdateServiceController(
        updateService: Get.find<UpdateService>(),
        existingService: service,
      ),
    );
  }
}
