import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/Data/models/loginResponseDTO.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';
import 'package:bookquotes/features/user/domain/repositories/UserDomainRepo.dart';
import 'package:dartz/dartz.dart';

class Login {
  final UserDomainRepository repository;

  Login({required this.repository});

  Future<Either<Failure, LoginResponseModel>> call(User user) async {
    return await repository.login(user);
  }
}
