class Motel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Motel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    return Motel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}
