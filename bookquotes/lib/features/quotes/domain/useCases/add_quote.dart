import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:bookquotes/features/quotes/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AddQuote {
  final QuotesRepository repository;

  AddQuote(this.repository);

  Future<Either<Failure, Quote>> call(Quote quote) async {
    return await repository.addQuote(quote);
  }
}