import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_service_management/presentation/widgets/service_title_desc_widget.dart';

import '../../domain/entities/service.dart';

class ServiceDetailPage extends StatelessWidget {
  final Service service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 210,
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
                  return const Icon(Icons.error_outline, color: Colors.red);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color:
                              service.availability ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        service.availability ? "Available" : "Not Available",
                        style: TextStyle(color: Colors.white),
                      )),
                  Row(
                    children: List.generate(
                      service.rating,
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 24),
                    ),
                  ),
                ],
              ),
            ),
            ServiceTitleDescriptionCard(
                title: 'Name', description: service.name),
            ServiceTitleDescriptionCard(
                title: 'Category', description: service.category),
            ServiceTitleDescriptionCard(
                title: 'Price',
                description: "\$${service.price.toStringAsFixed(2)}"),
            ServiceTitleDescriptionCard(
                title: 'Duration', description: service.duration),
          ],
        ),
      ),
    );
  }
}
