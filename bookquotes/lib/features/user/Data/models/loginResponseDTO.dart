import 'package:bookquotes/features/user/Data/models/user_model.dart';

class Loginresponsedto {
  final UserModel user;
  final String token;

  Loginresponsedto({required this.user, required this.token});

  factory Loginresponsedto.fromJson(Map<String, dynamic> json) =>
      Loginresponsedto(
        user: UserModel.fromJson(json['user']),
        token: json['token'] as String,
      );

  Map<String, dynamic> toJson() => {'user': user.toJson(), 'token': token};
}
