// injection_container.dart
import 'package:bookquotes/features/user/Data/dataSources/userRemote.dart';
import 'package:bookquotes/features/user/Presentation/authetications/bloc/auth_bloc.dart';
import 'package:bookquotes/features/user/data/repositories/repository_imp.dart';
import 'package:bookquotes/features/user/domain/repositories/UserDomainRepo.dart';
import 'package:bookquotes/features/user/domain/usecases/addUser.dart';
import 'package:bookquotes/features/user/domain/usecases/login.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> init() async {
  // Register http.Client
  if (!getIt.isRegistered<http.Client>()) {
    getIt.registerLazySingleton<http.Client>(() => http.Client());
  }

  // Register UserRemoteDataSource
  if (!getIt.isRegistered<UserRemoteDataSource>()) {
    getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: getIt<http.Client>()),
    );
  }

  // Register UserDomainRepository
  if (!getIt.isRegistered<UserDomainRepository>()) {
    getIt.registerLazySingleton<UserDomainRepository>(
      () => UserRepositoryImpl(remoteDataSource: getIt<UserRemoteDataSource>()),
    );
  }

  // Register Login use case
  if (!getIt.isRegistered<Login>()) {
    getIt.registerLazySingleton<Login>(
      () => Login(repository: getIt<UserDomainRepository>()),
    );
  }

  // Register Adduser use case
  if (!getIt.isRegistered<Adduser>()) {
    getIt.registerLazySingleton<Adduser>(
      () => Adduser(repository: getIt<UserDomainRepository>()),
    );
  }

  // Register AuthBloc
  if (!getIt.isRegistered<AuthBloc>()) {
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: getIt<Login>(),
        registerUseCase: getIt<Adduser>(),
      ),
    );
  }
}