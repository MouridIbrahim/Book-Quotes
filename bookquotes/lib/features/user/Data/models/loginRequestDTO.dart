

class Loginrequestdto {
  final String username;
  final String password;

  Loginrequestdto({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
