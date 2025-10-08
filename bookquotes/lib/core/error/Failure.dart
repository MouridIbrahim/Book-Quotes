import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}


// Server/API Failures
class ServerFailure extends Failure {
   const ServerFailure([super.message = 'Server error occurred']);
}

// Network Failures
class NetworkFailure extends Failure {
   const NetworkFailure([super.message = 'No internet connection']);
}

// Authentication Failures
class AuthenticationFailure extends Failure {
   const AuthenticationFailure([super.message = 'Authentication failed']);
}

class UnauthorizedFailure extends Failure {
   const UnauthorizedFailure([super.message = 'Unauthorized access']);
}

class TokenExpiredFailure extends Failure {
   const TokenExpiredFailure([super.message = 'Session expired. Please login again']);
}

// Validation Failures
class ValidationFailure extends Failure {
   const ValidationFailure([super.message = 'Invalid input']);
}

// Cache Failures
class CacheFailure extends Failure {
   const CacheFailure([super.message = 'Cache error occurred']);
}

// Not Found Failures
class NotFoundFailure extends Failure {
   const NotFoundFailure([super.message = 'Resource not found']);
}

// General Failures
class UnexpectedFailure extends Failure {
   const UnexpectedFailure([super.message = 'An unexpected error occurred']);
}

// Specific to your Book Quotes App
class QuoteNotFoundFailure extends Failure {
   const QuoteNotFoundFailure([super.message = 'Quote not found']);
}

class BookNotFoundFailure extends Failure {
   const BookNotFoundFailure([super.message = 'Book not found']);
}

class DuplicateQuoteFailure extends Failure {
   const DuplicateQuoteFailure([super.message = 'Quote already exists']);
}