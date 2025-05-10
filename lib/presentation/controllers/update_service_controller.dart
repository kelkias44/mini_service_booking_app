import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_service_management/presentation/controllers/service_controller.dart';
import '../../domain/entities/service.dart';
import '../../domain/usecases/update_service.dart';

class UpdateServiceController extends GetxController {
  final UpdateService updateService;
  final Service existingService;

  UpdateServiceController({
    required this.updateService,
    required this.existingService,
  });

  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController categoryController;
  late final TextEditingController priceController;
  late final TextEditingController imageUrlController;
  late final TextEditingController durationController;
  late final TextEditingController ratingController;
  var availability = true.obs;

  @override
  void onInit() {
    _initializeForm();
    super.onInit();
  }

  void _initializeForm() {
    nameController = TextEditingController(text: existingService.name);
    categoryController = TextEditingController(text: existingService.category);
    priceController =
        TextEditingController(text: existingService.price.toString());
    imageUrlController = TextEditingController(text: existingService.imageUrl);
    durationController = TextEditingController(text: existingService.duration);
    ratingController =
        TextEditingController(text: existingService.rating.toString());
    availability.value = existingService.availability;
  }

  String? validateNotEmpty(String? value) =>
      value?.isEmpty ?? true ? 'This field is required' : null;

  String? validatePrice(String? value) {
    if (value?.isEmpty ?? true) return 'Price is required';
    final price = double.tryParse(value!);
    if (price == null) return 'Invalid price format';
    if (price <= 0) return 'Price must be greater than 0';
    return null;
  }

  String? validateRating(String? value) {
    if (value?.isEmpty ?? true) return 'Rating is required';
    final rating = int.tryParse(value!);
    if (rating == null) return 'Invalid rating format';
    if (rating < 1 || rating > 5) return 'Rating must be 1-5';
    return null;
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    final updatedService = existingService.copyWith(
      name: nameController.text,
      category: categoryController.text,
      price: double.parse(priceController.text),
      imageUrl: imageUrlController.text,
      duration: durationController.text,
      availability: availability.value,
      rating: int.parse(ratingController.text),
    );

    final result = await updateService(updatedService);

    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) {
        Get.back();
        Get.find<ServicesController>().fetchServices();
        Get.snackbar('Success', 'Service updated successfully');
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    durationController.dispose();
    ratingController.dispose();
    super.onClose();
  }
}
