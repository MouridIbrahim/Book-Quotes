import 'package:bloc/bloc.dart';
import 'package:bookquotes/core/error/Failure.dart';
import 'package:bookquotes/core/services/token_storage.dart';
import 'package:bookquotes/features/user/Data/models/loginResponseDTO.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';
import 'package:bookquotes/features/user/domain/usecases/addUser.dart';
import 'package:bookquotes/features/user/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUseCase;
  final Adduser registerUseCase;
  final TokenStorageService tokenStorage;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.tokenStorage,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);
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
      password: event.password,
    );

    final result = await loginUseCase(user);
    print('🔵 BLoC: Login result received');
    
    await result.fold(
      (failure) {
        emit(AuthError(_mapFailureToMessage(failure)));
      },
      (loginResponse) async {
        // Store token and user info
        await tokenStorage.saveToken(loginResponse.token);
        await tokenStorage.saveUsername(loginResponse.username);
        await tokenStorage.setLoggedIn(true);
        
        print('✅ Token saved: ${loginResponse.token}');
        emit(LoginSuccess(loginResponse));
      },
    );
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    print('🔵 BLoC: Register process started for ${event.email}');
    
    final user = User(
      username: event.username,
      email: event.email,
      password: event.password,
    );

    final result = await registerUseCase(user);
    
    result.fold(
      (failure) {
        emit(AuthError(_mapFailureToMessage(failure)));
      },
      (user) {
        emit(RegisterSuccess(user));
      },
    );
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await tokenStorage.clearAll();
    print('🔴 User logged out, token cleared');
    emit(AuthInitial());
  }

  Future<void> _onCheckAuthEvent(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    final isLoggedIn = await tokenStorage.isLoggedIn();
    final username = await tokenStorage.getUsername();
    final token = await tokenStorage.getToken();
    
    if (isLoggedIn && token != null && username != null) {
      emit(Authenticated(username: username, token: token));
    } else {
      emit(AuthInitial());
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      default:
        return 'An unexpected error occurred';
    }
  }
}