class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final bool? isActive;
  final String? deviceId;
  bool isSelected;
  String? type;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl =
        'https://www.idocacademy.com/courses/assets/img/default_user.png',
    this.isSelected = false,
    this.isActive = true,
    this.deviceId,
    this.type = 'cliente',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        photoUrl: json['photoUrl'] ?? '',
        isSelected: json['isSelected'] ?? false,
        isActive: json['isActive'] ?? true,
        deviceId: json['deviceId'],
        type: json['type'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'isSelected': isSelected,
        'isActive': isActive,
        'deviceId': deviceId,
        'type': type
      };
}
