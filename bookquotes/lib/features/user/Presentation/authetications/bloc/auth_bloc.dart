// features/user/presentation/bloc/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/features/user/Data/models/loginResponseDTO.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';
import 'package:bookquotes/features/user/domain/usecases/addUser.dart';
import 'package:bookquotes/features/user/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUseCase;
  final Adduser registerUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
     print('🔵 BLoC: Login process started for ${event.email}');
    
    final user = User(
      username: '', // Not used in login
      email: event.email,
      password: event.password, // Pass actual password from event
    );

    final result = await loginUseCase(user);
    print('🔵 BLoC: Login result received');
    
    _handleAuthResult(result, emit, isLogin: true);
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    print('🔵 BLoC: Login process started for ${event.email}');
    final user = User(
      username: event.username,
      email: event.email,
      password: event.password, // Pass actual password from event
    );

    final result = await registerUseCase(user);
    
    _handleAuthResult(result, emit, isLogin: false);
  }

  void _handleAuthResult(
    Either<Failure, dynamic> result,
    Emitter<AuthState> emit, {
    required bool isLogin,
  }) {
    result.fold(
      (failure) {
        emit(AuthError(_mapFailureToMessage(failure)));
      },
      (success) {
        if (isLogin) {
          emit(LoginSuccess(success as LoginResponseModel));
        } else {
          emit(RegisterSuccess(success as User));
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      default:
        return 'An unexpected error occurred';
    }
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInitial());
  }
}