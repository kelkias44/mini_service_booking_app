import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_service_controller.dart';

class UpdateServicePage extends GetView<UpdateServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Service'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
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
        onPressed: controller.submitForm,
        child: const Text('Update Service'),
      );
}
