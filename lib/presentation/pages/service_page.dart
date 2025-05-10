import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_service_management/presentation/widgets/empty_service_widget.dart';
import '../../core/routes/app_routes.dart';
import '../controllers/service_controller.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/service_card.dart';

class ServicesPage extends GetView<ServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) return LoadingIndicator();
              if (controller.filteredServices.isEmpty)
                return EmptyServiceWidget();

              return RefreshIndicator(
                onRefresh: () async => await controller.fetchServices(),
                child: ListView.builder(
                  itemCount: controller.filteredServices.length,
                  itemBuilder: (ctx, i) => ServiceCard(
                    service: controller.filteredServices[i],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addService),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        hintText: 'Search services...',
        onChanged: (value) => controller.searchQuery.value = value,
        leading: const Icon(Icons.search),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Filter Services',
      content: Column(
        children: [
          _buildCategoryFilter(),
          _buildPriceFilter(),
          _buildRatingFilter(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: controller.resetFilters,
          child: const Text('Reset'),
        ),
        TextButton(
          onPressed: Get.back,
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Obx(
      () => DropdownButtonFormField<String>(
        value: controller.selectedCategory.value.isEmpty
            ? null
            : controller.selectedCategory.value,
        items: controller.categories.map((category) {
          return DropdownMenuItem(
            value: category == 'All Categories' ? '' : category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) => controller.selectedCategory.value = value ?? '',
        decoration: const InputDecoration(labelText: 'Category'),
      ),
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price Range'),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Min'),
                onChanged: (value) =>
                    controller.minPrice.value = double.tryParse(value) ?? 0,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Max'),
                onChanged: (value) => controller.maxPrice.value =
                    double.tryParse(value) ?? double.infinity,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Obx(
      () => DropdownButtonFormField<int>(
        value: controller.minRating.value,
        items: List.generate(
            6,
            (index) => DropdownMenuItem(
                  value: index,
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(' $index & up'),
                    ],
                  ),
                )),
        onChanged: (value) => controller.minRating.value = value ?? 0,
        decoration: const InputDecoration(labelText: 'Minimum Rating'),
      ),
    );
  }
}
