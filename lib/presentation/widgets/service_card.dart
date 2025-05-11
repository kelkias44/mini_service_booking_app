import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_service_management/domain/entities/service.dart';
import '../../core/routes/app_routes.dart';
import '../controllers/service_controller.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.serviceDetail, arguments: service),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: Image.network(
                      service.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error_outline,
                            color: Colors.red);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: service.availability ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      service.availability ? "Available" : "Not Available",
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                service.name,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                service.category,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${service.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: List.generate(
                      service.rating,
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Get.toNamed(
                        AppRoutes.updateService,
                        arguments: service,
                      ),
                      child: const Text('Edit'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _confirmDelete(service.id),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(String id) {
    Get.defaultDialog(
      title: 'Confirm Delete',
      content: const Text('Are you sure you want to delete this service?'),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Get.find<ServicesController>().removeService(id);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
