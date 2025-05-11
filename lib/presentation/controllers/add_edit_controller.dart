import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/service.dart';
import '../../domain/usecases/add_service.dart';
import 'service_controller.dart';

class AddServiceController extends GetxController {
  final AddService addService;

  AddServiceController({required this.addService});

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final durationController = TextEditingController();
  final ratingController = TextEditingController();
  var availability = true.obs;
  final imageFile = Rx<File?>(null);
  final isUploading = false.obs;
  final imageUrl = ''.obs;

  final cloudinary = Cloudinary.unsignedConfig(
    cloudName: "dyiwucaoz",
  );

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      await uploadImage();
    }
  }

  Future<void> uploadImage() async {
    try {
      isUploading(true);
      final file = imageFile.value!;
      final response = await cloudinary.unsignedUpload(
          file: file.path,
          uploadPreset: "kila_upload_preset",
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          fileName: '${DateTime.now().millisecondsSinceEpoch}',
          progressCallback: (count, total) {
            print('Uploading image from file with progress: $count/$total');
          });

      if (response.isSuccessful) {
        imageUrl.value = response.secureUrl!;
      } else {
        Get.snackbar('Error', 'Failed to upload image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Image upload failed: ${e.toString()}');
    } finally {
      isUploading(false);
    }
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

    final newService = Service(
      id: '',
      name: nameController.text,
      category: categoryController.text,
      price: double.parse(priceController.text),
      imageUrl: imageUrl.value,
      duration: durationController.text,
      availability: availability.value,
      rating: int.parse(ratingController.text),
    );

    final result = await addService(newService);

    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) {
        Get.back();
        Get.find<ServicesController>().fetchServices();
        Get.snackbar('Success', 'Service added successfully');
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    durationController.dispose();
    ratingController.dispose();
    super.onClose();
  }
}
