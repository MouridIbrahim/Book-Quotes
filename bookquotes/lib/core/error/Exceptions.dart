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
  const ServerException([super.message = 'Server error occurred', super.code]);
}

// Network Exceptions
class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

// Authentication Exceptions
class AuthException extends AppException {
  const AuthException([super.message = 'Authentication failed', super.code]);
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
  const ValidationException([super.message = 'Validation failed']);
}

// Cache Exceptions
class CacheException extends AppException {
  const CacheException([super.message = 'Cache operation failed']);
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