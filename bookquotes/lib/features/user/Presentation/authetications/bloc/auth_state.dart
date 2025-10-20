// features/user/presentation/bloc/auth/auth_state.dart
part of 'auth_bloc.dart';



abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginResponseModel loginResponse;

  const LoginSuccess(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class RegisterSuccess extends AuthState {
  final User user;

  const RegisterSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}