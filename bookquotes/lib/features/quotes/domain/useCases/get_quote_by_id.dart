
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:bookquotes/features/quotes/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetQuoteById {
  final QuotesRepository repository;

  GetQuoteById(this.repository);

  Future<Either<Failure, Quote>> call(int id) async {
    return await repository.getQuoteById(id);
  }
}