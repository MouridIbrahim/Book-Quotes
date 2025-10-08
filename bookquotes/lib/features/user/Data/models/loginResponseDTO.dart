class LoginResponseModel {
  final String token;
  final String username;
  final String message;

  LoginResponseModel({
    required this.token,
    required this.username,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      username: json['username'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
