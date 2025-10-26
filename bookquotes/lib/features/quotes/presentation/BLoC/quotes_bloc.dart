// features/quotes/presentation/bloc/quotes_bloc.dart

import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/quotes/domain/usecases/get_all_quotes.dart';
import 'package:bookquotes/features/quotes/domain/usecases/get_quote_by_id.dart';
import 'package:bookquotes/features/quotes/domain/usecases/add_quote.dart';
import 'package:bookquotes/features/quotes/domain/usecases/update_quote.dart';
import 'package:bookquotes/features/quotes/domain/usecases/delete_quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quotes_event.dart';
import 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final GetAllQuotes getAllQuotes;
  final GetQuoteById getQuoteById;
  final AddQuote addQuote;
  final UpdateQuote updateQuote;
  final DeleteQuote deleteQuote;

  QuotesBloc({
    required this.getAllQuotes,
    required this.getQuoteById,
    required this.addQuote,
    required this.updateQuote,
    required this.deleteQuote,
  }) : super(QuotesInitial()) {
    on<FetchAllQuotesEvent>(_onFetchAllQuotes);
    on<FetchQuoteByIdEvent>(_onFetchQuoteById);
    on<AddQuoteEvent>(_onAddQuote);
    on<UpdateQuoteEvent>(_onUpdateQuote);
    on<DeleteQuoteEvent>(_onDeleteQuote);
    on<RefreshQuotesEvent>(_onRefreshQuotes);
  }

  Future<void> _onFetchAllQuotes(
  FetchAllQuotesEvent event,
  Emitter<QuotesState> emit,
) async {
  emit(QuotesLoading());
  print('🔵 Fetching all quotes...');
  final result = await getAllQuotes();
  result.fold(
    (failure) {
      print('❌ Error fetching quotes: ${failure.message}');
      emit(QuotesError(message: _mapFailureToMessage(failure)));
    },
    (quotes) {
      print('✅ Quotes fetched successfully: ${quotes.length} quotes');
      emit(QuotesLoaded(quotes: quotes));
    },
  );
}

  Future<void> _onFetchQuoteById(
    FetchQuoteByIdEvent event,
    Emitter<QuotesState> emit,
  ) async {
    emit(QuotesLoading());
    final result = await getQuoteById(event.id);
    result.fold(
      (failure) => emit(QuotesError(message: _mapFailureToMessage(failure))),
      (quote) => emit(SingleQuoteLoaded(quote: quote)),
    );
  }

  Future<void> _onAddQuote(
    AddQuoteEvent event,
    Emitter<QuotesState> emit,
  ) async {
    emit(QuotesLoading());
    final result = await addQuote(event.quote);
    result.fold(
      (failure) => emit(AddQuoteError(message: _mapFailureToMessage(failure))),
      (quote) => emit(QuoteAdded(quote: quote)),
    );
  }

  Future<void> _onUpdateQuote(
    UpdateQuoteEvent event,
    Emitter<QuotesState> emit,
  ) async {
    emit(QuotesLoading());
    final result = await updateQuote(event.quote);
    result.fold(
      (failure) => emit(UpdateQuoteError(message: _mapFailureToMessage(failure))),
      (quote) => emit(QuoteUpdated(quote: quote)),
    );
  }

  Future<void> _onDeleteQuote(
    DeleteQuoteEvent event,
    Emitter<QuotesState> emit,
  ) async {
    emit(QuotesLoading());
    final result = await deleteQuote(event.id);
    result.fold(
      (failure) => emit(DeleteQuoteError(
        message: _mapFailureToMessage(failure),
        quoteId: event.id,
      )),
      (_) => emit(QuoteDeleted(quoteId: event.id)),
    );
  }

  Future<void> _onRefreshQuotes(
    RefreshQuotesEvent event,
    Emitter<QuotesState> emit,
  ) async {
    // For refresh, we might want to keep the current data visible
    // while fetching new data in the background
    if (state is QuotesLoaded) {
      final currentQuotes = (state as QuotesLoaded).quotes;
      emit(QuotesLoaded(quotes: currentQuotes)); // Maintain current data
    }
    
    final result = await getAllQuotes();
    result.fold(
      (failure) {
        // If refresh fails, we might want to show error but keep current data
        if (state is QuotesLoaded) {
          final currentQuotes = (state as QuotesLoaded).quotes;
          emit(QuotesLoaded(quotes: currentQuotes));
        } else {
          emit(QuotesError(message: _mapFailureToMessage(failure)));
        }
      },
      (quotes) => emit(QuotesLoaded(quotes: quotes)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}