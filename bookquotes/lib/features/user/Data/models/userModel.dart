// features/user/data/models/userModel.dart
import 'package:bookquotes/features/user/domain/entities/User.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    required super.username,
    required super.email,
    required super.password, // Add password
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'] ?? '', // Handle password from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password, // Include password
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      password: user.password, // Include password
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      password: password, // Include password
    );
  }
}