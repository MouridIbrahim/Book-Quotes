import 'package:dartz/dartz.dart';
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';


abstract class UserDomainRepository {
  Future<Either<Failure, User>> addUser(User user);
  Future<Either<Failure, User>> login(User user);
  Future<Either<Failure, Unit>> deleteUser(int id);
  Future<Either<Failure, User>> getUser(int id);
}