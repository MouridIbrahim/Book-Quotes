
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/domain/entities/entity.dart';
import 'package:dartz/dartz.dart';

abstract class QuotesRepository {
  Future<Either<Failure,Quote>> getAllQuotes();
  Future<Either<Failure,Quote>> getQuoteById(int id);
  Future<Either<Failure,Quote>> addQuote(Quote quote);
  Future<Either<Failure,Quote>> updateQuote(Quote quote);
  Future<Either<Failure,Unit>> deleteQuote(int id);
}