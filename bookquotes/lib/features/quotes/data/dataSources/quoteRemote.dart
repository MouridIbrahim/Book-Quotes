// features/quotes/data/datasources/quotes_remote_data_source.dart
import 'dart:convert';
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/data/Model/quotesModel.dart';
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class QuotesRemoteDataSource {
  Future<Either<Failure, List<Quote>>> getAllQuotes();
  Future<Either<Failure, Quote>> getQuoteById(int id);
}

class QuotesRemoteDataSourceImpl implements QuotesRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'http://10.42.254.252:8080/api/quotes';

  QuotesRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, List<Quote>>> getAllQuotes() async {
    try {
      print('🌐 Fetching quotes from: $baseUrl/all');
      
      final response = await client.get(
        Uri.parse('$baseUrl/all'),
        headers: {'Content-Type': 'application/json'},
      );

      print('📡 Response status code: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        print('✅ Successfully parsed ${jsonList.length} quotes');
        final quotes = jsonList.map((json) => QuoteModel.fromJson(json)).toList();
        return Right(quotes);
      } else if (response.statusCode == 401) {
        print('❌ Unauthorized (401)');
        return const Left(UnauthorizedFailure());
      } else if (response.statusCode == 404) {
        print('❌ Not Found (404)');
        return const Left(NotFoundFailure());
      } else if (response.statusCode >= 500) {
        print('❌ Server Error (${response.statusCode})');
        return const Left(ServerFailure());
      } else {
        print('❌ Unexpected status code: ${response.statusCode}');
        return const Left(UnexpectedFailure());
      }
    } on http.ClientException catch (e) {
      print('❌ Network error: ${e.message}');
      return Left(NetworkFailure(e.message));
    } on FormatException catch (e) {
      print('❌ Format error: ${e.message}');
      return Left(ServerFailure('Invalid response format: ${e.message}'));
    } catch (e) {
      print('❌ Unexpected error: $e');
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Quote>> getQuoteById(int id) async {
    try {
      print('🌐 Fetching quote by ID: $baseUrl/$id');
      
      final response = await client.get(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      print('📡 Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final quote = QuoteModel.fromJson(jsonData);
        return Right(quote);
      } else if (response.statusCode == 401) {
        return const Left(UnauthorizedFailure());
      } else if (response.statusCode == 404) {
        return const Left(QuoteNotFoundFailure());
      } else if (response.statusCode >= 500) {
        return const Left(ServerFailure());
      } else {
        return const Left(UnexpectedFailure());
      }
    } on http.ClientException catch (e) {
      print('❌ Network error: ${e.message}');
      return Left(NetworkFailure(e.message));
    } on FormatException catch (e) {
      print('❌ Format error: ${e.message}');
      return Left(ServerFailure('Invalid response format: ${e.message}'));
    } catch (e) {
      print('❌ Unexpected error: $e');
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}