import 'package:bookquotes/features/quotes/domain/repository/repository.dart';

class GetAllQuotes {
  QuotesRepository repository;
  GetAllQuotes(this.repository);
  Future call() async {
    return await repository.getAllQuotes();
  }
}
