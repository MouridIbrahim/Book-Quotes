import 'dart:convert';

import 'package:bookquotes/core/Constants.dart';
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/Data/models/loginRequestDTO.dart';
import 'package:bookquotes/features/user/Data/models/loginResponseDTO.dart';
import 'package:bookquotes/features/user/Data/models/signUpRequestDTO.dart';
import 'package:bookquotes/features/user/Data/models/userModel.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<Either<Failure, UserModel>> addUser(SignupRequestDTO dto);
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestDTO loginDTO);
  Future<Either<Failure, Unit>> deleteUser(int id, String token);
  Future<Either<Failure, UserModel>> getUser(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, UserModel>> addUser(SignupRequestDTO dto) async {
    try {
      final response = await client.post(
        Uri.parse('http://localhost:8080/api/users/signup'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(dto.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Right(UserModel.fromJson(jsonData));
      } else {
        return Left(
          ServerFailure('Failed to register user: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(ServerFailure('Error registering user: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int id, String token) async {
    try {
      final response = await client.delete(
        Uri.parse('http://localhost:8080/api/users/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // ✅ send JWT
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(unit);
      } else {
        return Left(
          ServerFailure('Failed to delete user: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(ServerFailure('Error deleting user: $e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser(int id) async {
    try {
      final response = await client.get(Uri.parse("$apiBaseUrl/$id"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Right(UserModel.fromJson(jsonData));
      } else {
        return Left(
          ServerFailure('Failed to get user: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(ServerFailure('Error fetching user: $e'));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestDTO dto) async {
    try {
      final response = await client.post(
        Uri.parse('http://localhost:8080/api/users/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(dto.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Right(LoginResponseModel.fromJson(jsonData));
      } else {
        return Left(ServerFailure('Login failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(ServerFailure('Error logging in: $e'));
    }
  }
}
