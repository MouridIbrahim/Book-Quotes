// features/quotes/presentation/pages/home_page.dart
import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:bookquotes/features/quotes/presentation/bloc/quotes_bloc.dart';
import 'package:bookquotes/features/quotes/presentation/bloc/quotes_event.dart';
import 'package:bookquotes/features/quotes/presentation/bloc/quotes_state.dart';
import 'package:bookquotes/features/quotes/presentation/appBody/screens/add_quote_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch quotes when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuotesBloc>().add(FetchAllQuotesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.textWhiteColor,
        centerTitle: true,
        title: const Text(
          "Book Quotes",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          // Add Quote Button
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddQuotePage()),
              );
            },
            tooltip: 'Add Quote',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocConsumer<QuotesBloc, QuotesState>(
        listener: (context, state) {
          // Handle specific states that might need side effects
          if (state is QuoteAdded) {
            _showSnackBar(context, 'Quote added successfully!', Colors.green);
            // Refresh the quotes list after adding
            context.read<QuotesBloc>().add(FetchAllQuotesEvent());
          } else if (state is QuoteUpdated) {
            _showSnackBar(context, 'Quote updated successfully!', Colors.green);
            // Refresh the quotes list after updating
            context.read<QuotesBloc>().add(FetchAllQuotesEvent());
          } else if (state is QuoteDeleted) {
            _showSnackBar(context, 'Quote deleted successfully!', Colors.green);
            // Refresh the quotes list after deleting
            context.read<QuotesBloc>().add(FetchAllQuotesEvent());
          } else if (state is AddQuoteError) {
            _showSnackBar(context, state.message, Colors.red);
          } else if (state is UpdateQuoteError) {
            _showSnackBar(context, state.message, Colors.red);
          } else if (state is DeleteQuoteError) {
            _showSnackBar(context, state.message, Colors.red);
          }
        },
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, QuotesState state) {
    if (state is QuotesLoading) {
      return _buildLoadingState();
    } else if (state is QuotesLoaded) {
      return state.quotes.isEmpty
          ? _buildEmptyState()
          : _buildQuotesList(state.quotes);
    } else if (state is QuotesError) {
      return _buildErrorState(state.message);
    } else if (state is AddQuoteError) {
      return _buildErrorState(state.message, showRetry: false);
    } else if (state is UpdateQuoteError) {
      return _buildErrorState(state.message, showRetry: false);
    } else if (state is DeleteQuoteError) {
      return _buildErrorState(state.message, showRetry: false);
    } else if (state is QuoteAdded ||
        state is QuoteUpdated ||
        state is QuoteDeleted) {
      // These states are handled in the listener, but we need to show loading
      // while we refresh the list after the operation
      return _buildLoadingState();
    }

    // Initial state
    return _buildInitialState();
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading quotes...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildQuotesList(List<Quote> quotes) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<QuotesBloc>().add(FetchAllQuotesEvent());
      },
      child: ListView.builder(
        itemCount: quotes.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final quote = quotes[index];
          return _buildQuoteCard(quote, index);
        },
      ),
    );
  }

  Widget _buildQuoteCard(Quote quote, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote text
            Text(
              '"${quote.text}"',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Author and book information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quote ID (if available)
                if (quote.id != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '#${quote.id}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                // Author and book
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '- ${quote.author}, ${quote.book}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, {bool showRetry = true}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            if (showRetry) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<QuotesBloc>().add(FetchAllQuotesEvent());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.buttonColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.format_quote, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'No Quotes Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'There are no quotes available at the moment.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<QuotesBloc>().add(FetchAllQuotesEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Refresh',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.format_quote, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'Welcome to Book Quotes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the refresh button to load your favorite book quotes',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<QuotesBloc>().add(FetchAllQuotesEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Load Quotes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
