import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DeleteQuote {
  final QuotesRepository repository;

  DeleteQuote(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteQuote(id);
  }
}