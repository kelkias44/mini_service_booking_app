class Service {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String duration;
  final bool availability;
  final int rating;

  double get getPrice => price;
  String get getCategory => category;
  int get getRating => rating;

  Service({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.duration,
    required this.availability,
    required this.rating,
  });
  Service copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    String? imageUrl,
    String? duration,
    bool? availability,
    int? rating,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      duration: duration ?? this.duration,
      availability: availability ?? this.availability,
      rating: rating ?? this.rating,
    );
  }
}
