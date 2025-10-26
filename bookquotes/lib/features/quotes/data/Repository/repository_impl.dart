// features/quotes/data/repositories/quotes_repository_impl.dart
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/data/dataSources/quoteRemote.dart';
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';

import 'package:bookquotes/features/quotes/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final QuotesRemoteDataSource remoteDataSource;

  QuotesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Quote>>> getAllQuotes() async {
    return await remoteDataSource.getAllQuotes();
  }

  @override
  Future<Either<Failure, Quote>> getQuoteById(int id) async {
    return await remoteDataSource.getQuoteById(id);
  }
  
  @override
  Future<Either<Failure, Quote>> addQuote(Quote quote) {
    // TODO: implement addQuote
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> deleteQuote(int id) {
    // TODO: implement deleteQuote
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Quote>> updateQuote(Quote quote) {
    // TODO: implement updateQuote
    throw UnimplementedError();
  }

  
}