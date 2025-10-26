
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:equatable/equatable.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<Quote> quotes;

  const QuotesLoaded({required this.quotes});

  @override
  List<Object> get props => [quotes];
}

class SingleQuoteLoaded extends QuotesState {
  final Quote quote;

  const SingleQuoteLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class QuoteAdded extends QuotesState {
  final Quote quote;

  const QuoteAdded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class QuoteUpdated extends QuotesState {
  final Quote quote;

  const QuoteUpdated({required this.quote});

  @override
  List<Object> get props => [quote];
}

class QuoteDeleted extends QuotesState {
  final int quoteId;

  const QuoteDeleted({required this.quoteId});

  @override
  List<Object> get props => [quoteId];
}

class QuotesError extends QuotesState {
  final String message;

  const QuotesError({required this.message});

  @override
  List<Object> get props => [message];
}

class AddQuoteError extends QuotesState {
  final String message;

  const AddQuoteError({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateQuoteError extends QuotesState {
  final String message;

  const UpdateQuoteError({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteQuoteError extends QuotesState {
  final String message;
  final int quoteId;

  const DeleteQuoteError({required this.message, required this.quoteId});

  @override
  List<Object> get props => [message, quoteId];
}