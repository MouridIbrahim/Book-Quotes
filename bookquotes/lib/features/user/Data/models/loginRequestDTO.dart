class LoginRequestDTO {
  final String username;
  final String password;

  LoginRequestDTO({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
