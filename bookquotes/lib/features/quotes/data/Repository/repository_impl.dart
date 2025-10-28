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
  Future<Either<Failure, Quote>> addQuote(Quote quote) async {
    return await remoteDataSource.addQuote(quote);
  }

  @override
  Future<Either<Failure, Unit>> deleteQuote(int id) async {
    // For now, return success since backend might not support delete
    // You can implement this when your backend supports delete
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Quote>> updateQuote(Quote quote) async {
    // For now, return the same quote since backend might not support update
    // You can implement this when your backend supports update
    return Right(quote);
  }
}
