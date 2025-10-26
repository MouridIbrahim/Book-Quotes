
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:bookquotes/features/quotes/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class SearchQuotes {
  final QuotesRepository repository;

  SearchQuotes(this.repository);

  Future<Either<Failure, List<Quote>>> call(String query) async {
    if (query.isEmpty) {
      return const Left(ValidationFailure('Search query cannot be empty'));
    }
    
    // Note: You'll need to add searchQuotes method to your repository
    // return await repository.searchQuotes(query);
    
    // For now, we'll return a not implemented error
    return Left(UnexpectedFailure('Search functionality not implemented'));
  }
}