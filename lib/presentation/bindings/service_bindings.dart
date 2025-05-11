import 'package:get/get.dart';
import '../../core/network/dio_client.dart';
import '../../data/datasources/service_remote_data_source.dart';
import '../../data/repositories/service_repository_impl.dart';
import '../../domain/repositories/service_repository.dart';
import '../../domain/usecases/add_service.dart';
import '../../domain/usecases/delete_service.dart';
import '../../domain/usecases/get_service.dart';
import '../../domain/usecases/update_service.dart';
import '../controllers/service_controller.dart';

class ServicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSource(dioClient: Get.find()),
    );

    Get.lazyPut<ServiceRepository>(
      () => ServiceRepositoryImpl(remoteDataSource: Get.find()),
    );

    Get.lazyPut<GetServices>(() => GetServices(Get.find()));
    Get.lazyPut<AddService>(() => AddService(Get.find()));
    Get.lazyPut<DeleteService>(() => DeleteService(Get.find()));
    Get.lazyPut<UpdateService>(
        () => UpdateService(Get.find<ServiceRepository>()));

    Get.lazyPut(() =>
        ServicesController(getServices: Get.find(), deleteService: Get.find()));
  }
}
