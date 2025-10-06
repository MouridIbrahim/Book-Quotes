import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure(this.message);

  @override
  List<Object?> get props => [message];
}


// Server/API Failures
class ServerFailure extends Failure {
   ServerFailure([String message = 'Server error occurred']) : super(message);
}

// Network Failures
class NetworkFailure extends Failure {
   NetworkFailure([String message = 'No internet connection']) : super(message);
}

// Authentication Failures
class AuthenticationFailure extends Failure {
   AuthenticationFailure([String message = 'Authentication failed']) : super(message);
}

class UnauthorizedFailure extends Failure {
   UnauthorizedFailure([String message = 'Unauthorized access']) : super(message);
}

class TokenExpiredFailure extends Failure {
   TokenExpiredFailure([String message = 'Session expired. Please login again']) : super(message);
}

// Validation Failures
class ValidationFailure extends Failure {
   ValidationFailure([String message = 'Invalid input']) : super(message);
}

// Cache Failures
class CacheFailure extends Failure {
   CacheFailure([String message = 'Cache error occurred']) : super(message);
}

// Not Found Failures
class NotFoundFailure extends Failure {
   NotFoundFailure([String message = 'Resource not found']) : super(message);
}

// General Failures
class UnexpectedFailure extends Failure {
   UnexpectedFailure([String message = 'An unexpected error occurred']) : super(message);
}

// Specific to your Book Quotes App
class QuoteNotFoundFailure extends Failure {
   QuoteNotFoundFailure([String message = 'Quote not found']) : super(message);
}

class BookNotFoundFailure extends Failure {
   BookNotFoundFailure([String message = 'Book not found']) : super(message);
}

class DuplicateQuoteFailure extends Failure {
   DuplicateQuoteFailure([String message = 'Quote already exists']) : super(message);
}