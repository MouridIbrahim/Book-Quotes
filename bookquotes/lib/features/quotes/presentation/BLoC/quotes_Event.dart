// features/quotes/presentation/bloc/quotes_event.dart

import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:equatable/equatable.dart';

abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object> get props => [];
}

class FetchAllQuotesEvent extends QuotesEvent {}

class FetchQuoteByIdEvent extends QuotesEvent {
  final int id;

  const FetchQuoteByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddQuoteEvent extends QuotesEvent {
  final Quote quote;

  const AddQuoteEvent(this.quote);

  @override
  List<Object> get props => [quote];
}

class UpdateQuoteEvent extends QuotesEvent {
  final Quote quote;

  const UpdateQuoteEvent(this.quote);

  @override
  List<Object> get props => [quote];
}

class DeleteQuoteEvent extends QuotesEvent {
  final int id;

  const DeleteQuoteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshQuotesEvent extends QuotesEvent {}
