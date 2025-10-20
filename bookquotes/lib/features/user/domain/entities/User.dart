// features/user/domain/entities/User.dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String username;
  final String email;
  final String password; // Add password field

  const User({
    this.id,
    required this.username,
    required this.email,
    required this.password, // Make password required
  });

  @override
  List<Object?> get props => [id, username, email, password];
  
  // Create a copyWith method for convenience
  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}