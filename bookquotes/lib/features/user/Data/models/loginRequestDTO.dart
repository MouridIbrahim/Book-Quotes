// features/user/data/models/loginRequestDTO.dart
class LoginRequestDTO {
  final String email;  // Changed from username to email
  final String password;

  LoginRequestDTO({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};  // Updated key
  }
}