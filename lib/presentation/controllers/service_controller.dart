import 'package:get/get.dart';

import '../../domain/entities/service.dart';
import '../../domain/usecases/delete_service.dart';
import '../../domain/usecases/get_service.dart';

class ServicesController extends GetxController {
  final GetServices getServices;
  final DeleteService deleteService;
  final services = <Service>[].obs;
  final isLoading = false.obs;

  final searchQuery = ''.obs;
  final selectedCategory = RxString('');
  final minPrice = RxDouble(0);
  final maxPrice = RxDouble(double.infinity);
  final minRating = RxInt(0);

  ServicesController({
    required this.getServices,
    required this.deleteService,
  });

  @override
  void onInit() {
    fetchServices();
    debounce(searchQuery, (_) => update(),
        time: const Duration(milliseconds: 500));
    super.onInit();
  }

  List<Service> get filteredServices => services.where((service) {
        final matchesSearch = service.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            service.category
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
        final matchesCategory = selectedCategory.value.isEmpty ||
            service.category == selectedCategory.value;
        final matchesPrice =
            service.price >= minPrice.value && service.price <= maxPrice.value;
        final matchesRating = service.rating >= minRating.value;

        return matchesSearch &&
            matchesCategory &&
            matchesPrice &&
            matchesRating;
      }).toList();

  List<String> get categories =>
      services.map((s) => s.category).toSet().toList()
        ..insert(0, 'All Categories');

  void resetFilters() {
    searchQuery.value = '';
    selectedCategory.value = '';
    minPrice.value = 0;
    maxPrice.value = double.infinity;
    minRating.value = 0;
  }

  Future<void> fetchServices() async {
    isLoading(true);
    final result = await getServices();
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (services) => this.services.assignAll(services),
    );
    isLoading(false);
  }

  Future<void> removeService(String id) async {
    final result = await deleteService(id);
    result.fold(
      (failure) {
        Get.snackbar('Error', failure.message);
      },
      (deletedService) async {
        services.removeWhere((service) => service.id == id);
        Get.snackbar('Success', 'Service deleted successfully');
      },
    );
  }
}
