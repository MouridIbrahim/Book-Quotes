// lib/features/user/data/models/user_model.dart


import 'package:bookquotes/features/user/domain/entities/User.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    required super.username,
    required super.email,
  });

  /// 🔹 Convert backend JSON → UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  /// 🔹 Convert UserModel → JSON for backend
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
    };
  }

  /// 🔹 Convert Domain Entity → UserModel
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
    );
  }

  /// 🔹 Convert UserModel → Domain Entity
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
    );
  }
}
