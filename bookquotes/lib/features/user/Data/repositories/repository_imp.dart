// features/user/data/repositories/repository_imp.dart
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/Data/dataSources/userRemote.dart';
import 'package:bookquotes/features/user/Data/models/loginRequestDTO.dart';
import 'package:bookquotes/features/user/Data/models/loginResponseDTO.dart';
import 'package:bookquotes/features/user/Data/models/signUpRequestDTO.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';
import 'package:bookquotes/features/user/domain/repositories/UserDomainRepo.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserDomainRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> addUser(User user) async {
    try {
      // Use the actual password from the user entity
      final dto = SignupRequestDTO(
        username: user.username,
        email: user.email,
        password: user.password, // Use actual password from user
      );

      final result = await remoteDataSource.addUser(dto);
      return result.map((userModel) => userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> login(User user) async {
    try {
      
      final dto = LoginRequestDTO(
        email: user.email, 
        password: user.password
      );

      final result = await remoteDataSource.login(dto);
      return result;
    } catch (e) {
      return Left(ServerFailure('Error logging in: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int id, String token) async {
    try {
      return await remoteDataSource.deleteUser(id, token);
    } catch (e) {
      return Left(ServerFailure('Error deleting user: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(int id) async {
    try {
      final result = await remoteDataSource.getUser(id);
      return result.map((userModel) => userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}