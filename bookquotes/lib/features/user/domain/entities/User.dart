import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int? id;
  final String username;
  final String email;

  const User({
     this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [id, username, email];
  
}