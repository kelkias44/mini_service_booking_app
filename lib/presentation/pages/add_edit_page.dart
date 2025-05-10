import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_service_management/presentation/controllers/add_edit_controller.dart';

class AddServicePage extends GetView<AddServiceController> {
  final imageFile = Rx<File?>(null);
  final isUploading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Service'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              _buildImageUploadSection(),
              _buildNameField(),
              _buildCategoryField(),
              _buildPriceField(),
              _buildDurationField(),
              _buildRatingField(),
              _buildAvailabilitySwitch(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() => Column(
        children: [
          Obx(() {
            if (controller.imageFile.value != null) {
              return Image.file(controller.imageFile.value!);
            }
            return const SizedBox.shrink();
          }),
          Obx(() {
            if (controller.isUploading.value) {
              return const CircularProgressIndicator();
            }
            return Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.pickImage(ImageSource.gallery),
                    child: const Text('Gallery'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.pickImage(ImageSource.camera),
                    child: const Text('Camera'),
                  ),
                ),
              ],
            );
          }),
          Obx(() {
            if (controller.imageUrl.isNotEmpty) {
              return const Text('Image uploaded!',
                  style: TextStyle(color: Colors.green));
            }
            return const SizedBox.shrink();
          }),
        ],
      );
  Widget _buildNameField() => TextFormField(
        controller: controller.nameController,
        decoration: const InputDecoration(labelText: 'Service Name'),
        validator: controller.validateNotEmpty,
      );

  Widget _buildCategoryField() => TextFormField(
        controller: controller.categoryController,
        decoration: const InputDecoration(labelText: 'Category'),
        validator: controller.validateNotEmpty,
      );

  Widget _buildPriceField() => TextFormField(
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Price'),
        validator: controller.validatePrice,
      );

  Widget _buildDurationField() => TextFormField(
        controller: controller.durationController,
        decoration: const InputDecoration(labelText: 'Duration'),
        validator: controller.validateNotEmpty,
      );

  Widget _buildRatingField() => TextFormField(
        controller: controller.ratingController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Rating (1-5)'),
        validator: controller.validateRating,
      );

  Widget _buildAvailabilitySwitch() => Obx(() => SwitchListTile(
        title: const Text('Available'),
        value: controller.availability.value,
        onChanged: (value) => controller.availability.value = value,
      ));

  Widget _buildSubmitButton() => ElevatedButton(
        onPressed: () {
          if (controller.imageUrl.isEmpty) {
            Get.snackbar('Error', 'Please upload an image first');
            return;
          }
          controller.submitForm();
        },
        child: const Text('Add Service'),
      );
}
