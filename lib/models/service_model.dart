class ServiceModel {
  final String id;
  final String clientId;
  final String name;
  final String description;
  final double price;

  ServiceModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.description,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      clientId: json['clientId'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
