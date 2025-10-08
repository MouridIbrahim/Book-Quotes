import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';
import 'package:bookquotes/features/user/domain/repositories/UserDomainRepo.dart';
import 'package:dartz/dartz.dart';

class Adduser {
  final UserDomainRepository repository;

  Adduser({required this.repository});

  Future<Either<Failure, User>> call(User user) async {
    return await repository.addUser(user);
  }
}
