import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/domain/repositories/UserDomainRepo.dart';
import 'package:dartz/dartz.dart';

class Deleteuser {
  final UserDomainRepository repository;

  Deleteuser({required this.repository});

  Future<Either<Failure, Unit>> call(int userId,String token) async {
    return await repository.deleteUser(userId,token);
  }
}
