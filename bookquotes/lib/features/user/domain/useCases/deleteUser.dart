import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/domain/repositories/User_domain_repo.dart';
import 'package:dartz/dartz.dart';

class Deleteuser {
  final UserDomainRepository repository;

  Deleteuser({required this.repository});

  Future<Either<Failure, Unit>> call(int userId) async {
    return await repository.deleteUser(userId);
  }
}
