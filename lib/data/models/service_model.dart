import '../../domain/entities/service.dart';

class ServiceModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String duration;
  final bool availability;
  final int rating;

  ServiceModel.fromEntity(Service entity)
      : id = entity.id,
        name = entity.name,
        category = entity.category,
        price = entity.price,
        imageUrl = entity.imageUrl,
        duration = entity.duration,
        availability = entity.availability,
        rating = entity.rating;

  Service toEntity() => Service(
        id: id,
        name: name,
        category: category,
        price: price,
        imageUrl: imageUrl,
        duration: duration,
        availability: availability,
        rating: rating,
      );

  ServiceModel.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString() ?? '',
        name = json['name']?.toString() ?? '',
        category = json['category']?.toString() ?? 'General',
        price = (json['price'] as num?)?.toDouble() ?? 0.0,
        imageUrl = json['imageUrl']?.toString() ?? '',
        duration = json['duration']?.toString() ?? '0 mins',
        availability = json['availability'] as bool? ?? false,
        rating = (json['rating'] as num?)?.toInt() ?? 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'imageUrl': imageUrl,
        'duration': duration,
        'availability': availability,
        'rating': rating,
      };
}
