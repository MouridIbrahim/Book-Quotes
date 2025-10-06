import 'package:bookquotes/features/user/domain/entities/User.dart';

class UserModel extends User {
  final int id;
  final String username;
  final String email;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
  }) : super(id: id, username: username, email: email);

  /// Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    username: json['username'] as String,
    email: json['email'] as String,
  );

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
  };

  /// Map UserModel to Domain Entity
  User toEntity() => User(id: id, username: username, email: email);
}
