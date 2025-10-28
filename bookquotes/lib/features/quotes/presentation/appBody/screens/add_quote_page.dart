import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';
import 'package:bookquotes/features/quotes/presentation/bloc/quotes_bloc.dart';
import 'package:bookquotes/features/quotes/presentation/bloc/quotes_event.dart';
import 'package:bookquotes/features/quotes/presentation/bloc/quotes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuotePage extends StatefulWidget {
  const AddQuotePage({super.key});

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  final TextEditingController quoteContent = TextEditingController();
  final TextEditingController authorName = TextEditingController();
  final TextEditingController bookTitle = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    quoteContent.dispose();
    authorName.dispose();
    bookTitle.dispose();
    super.dispose();
  }

  void _saveQuote() {
    if (_formKey.currentState!.validate()) {
      final quote = Quote(
        text: quoteContent.text.trim(),
        author: authorName.text.trim(),
        book: bookTitle.text.trim(),
      );

      context.read<QuotesBloc>().add(AddQuoteEvent(quote));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textWhiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text('New Quote'),
        backgroundColor: AppColor.textWhiteColor,
      ),
      body: BlocListener<QuotesBloc, QuotesState>(
        listener: (context, state) {
          if (state is QuoteAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Quote added successfully!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
            Navigator.pop(context);
          } else if (state is AddQuoteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildModernTextField(
                      controller: quoteContent,
                      hintText: 'Enter the quote content',
                      width: double.infinity,
                      height: 350,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the quote content';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    _buildModernTextField(
                      controller: authorName,
                      hintText: 'Author name',
                      width: double.infinity,
                      height: 60,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter author name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    _buildModernTextField(
                      controller: bookTitle,
                      hintText: 'Book title',
                      width: double.infinity,
                      height: 60,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter book title';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<QuotesBloc, QuotesState>(
          builder: (context, state) {
            final isLoading = state is QuotesLoading;

            return ElevatedButton(
              onPressed: isLoading ? null : _saveQuote,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                minimumSize: const Size(double.infinity, 50),
                disabledBackgroundColor: AppColor.buttonColor.withOpacity(0.6),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildModernTextField({
  required TextEditingController controller,
  required String hintText,
  required double width,
  required double height,
  String? Function(String?)? validator,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      maxLines: height > 100 ? null : 1,
      validator: validator,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFAAAAAA),
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: const TextStyle(fontSize: 12, height: 0.8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
    ),
  );
}