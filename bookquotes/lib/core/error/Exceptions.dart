// Base Exception
class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
  
  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

// Server Exceptions
class ServerException extends AppException {
  const ServerException([String message = 'Server error occurred', String? code]) 
      : super(message, code);
}

// Network Exceptions
class NetworkException extends AppException {
  const NetworkException([String message = 'No internet connection']) 
      : super(message);
}

// Authentication Exceptions
class AuthException extends AppException {
  const AuthException([String message = 'Authentication failed', String? code]) 
      : super(message, code);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String message = 'Unauthorized access']) 
      : super(message, '401');
}

class TokenExpiredException extends AppException {
  const TokenExpiredException([String message = 'Token expired']) 
      : super(message, '401');
}

// Validation Exceptions
class ValidationException extends AppException {
  const ValidationException([String message = 'Validation failed']) 
      : super(message);
}

// Cache Exceptions
class CacheException extends AppException {
  const CacheException([String message = 'Cache operation failed']) 
      : super(message);
}

// Not Found Exceptions
class NotFoundException extends AppException {
  const NotFoundException([String message = 'Resource not found']) 
      : super(message, '404');
}

// Timeout Exceptions
class TimeoutException extends AppException {
  const TimeoutException([String message = 'Request timeout']) 
      : super(message, '408');
}

// Bad Request Exceptions
class BadRequestException extends AppException {
  const BadRequestException([String message = 'Bad request']) 
      : super(message, '400');
}

// Conflict Exceptions (for duplicates)
class ConflictException extends AppException {
  const ConflictException([String message = 'Resource already exists']) 
      : super(message, '409');
}