// Unified Dependency Injection Container
// This file contains ALL dependencies for the entire app

// Quotes imports
import 'package:bookquotes/features/quotes/data/Repository/repository_impl.dart';
import 'package:bookquotes/features/quotes/data/dataSources/quoteRemote.dart';
import 'package:bookquotes/features/quotes/domain/repository/repository.dart';
import 'package:bookquotes/features/quotes/domain/usecases/get_all_quotes.dart';
import 'package:bookquotes/features/quotes/domain/usecases/get_quote_by_id.dart';
import 'package:bookquotes/features/quotes/domain/usecases/add_quote.dart';
import 'package:bookquotes/features/quotes/domain/usecases/update_quote.dart';
import 'package:bookquotes/features/quotes/domain/usecases/delete_quote.dart';
import 'package:bookquotes/features/quotes/presentation/bloc/quotes_bloc.dart';

// Auth imports
import 'package:bookquotes/features/user/Presentation/authetications/bloc/auth_bloc.dart';
import 'package:bookquotes/features/user/domain/usecases/login.dart';
import 'package:bookquotes/features/user/domain/usecases/addUser.dart';
import 'package:bookquotes/features/user/domain/repositories/UserDomainRepo.dart';
import 'package:bookquotes/features/user/Data/repositories/repository_imp.dart';
import 'package:bookquotes/features/user/Data/dataSources/userRemote.dart' as auth_remote;
import 'package:bookquotes/core/services/token_storage.dart';

// External
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Single global GetIt instance for the entire app
final sl = GetIt.instance;

Future<void> init() async {
  try {
    print('🔵 Starting unified dependency injection...');

    //! ========== EXTERNAL (Register shared dependencies first) ==========
    if (!sl.isRegistered<http.Client>()) {
      sl.registerLazySingleton(() => http.Client());
      print('✅ http.Client registered');
    }

    //! ========== CORE SERVICES ==========
    if (!sl.isRegistered<TokenStorageService>()) {
      sl.registerLazySingleton(() => TokenStorageService());
      print('✅ TokenStorageService registered');
    }

    //! ========== FEATURES - QUOTES ==========
    print('📦 Registering Quotes dependencies...');

    // Data sources
    if (!sl.isRegistered<QuotesRemoteDataSource>()) {
      sl.registerLazySingleton<QuotesRemoteDataSource>(
        () => QuotesRemoteDataSourceImpl(client: sl()),
      );
    }

    // Repository
    if (!sl.isRegistered<QuotesRepository>()) {
      sl.registerLazySingleton<QuotesRepository>(
        () => QuotesRepositoryImpl(remoteDataSource: sl()),
      );
    }

    // Use cases
    if (!sl.isRegistered<GetAllQuotes>()) {
      sl.registerLazySingleton(() => GetAllQuotes(sl()));
    }
    if (!sl.isRegistered<GetQuoteById>()) {
      sl.registerLazySingleton(() => GetQuoteById(sl()));
    }
    if (!sl.isRegistered<AddQuote>()) {
      sl.registerLazySingleton(() => AddQuote(sl()));
    }
    if (!sl.isRegistered<UpdateQuote>()) {
      sl.registerLazySingleton(() => UpdateQuote(sl()));
    }
    if (!sl.isRegistered<DeleteQuote>()) {
      sl.registerLazySingleton(() => DeleteQuote(sl()));
    }

    // Bloc
    if (!sl.isRegistered<QuotesBloc>()) {
      sl.registerFactory(() => QuotesBloc(
            getAllQuotes: sl(),
            getQuoteById: sl(),
            addQuote: sl(),
            updateQuote: sl(),
            deleteQuote: sl(),
          ));
    }

    print('✅ Quotes dependencies registered');

    //! ========== FEATURES - AUTH ==========
    print('🔐 Registering Auth dependencies...');

    // Data sources
    if (!sl.isRegistered<auth_remote.UserRemoteDataSource>()) {
      sl.registerLazySingleton<auth_remote.UserRemoteDataSource>(
        () => auth_remote.UserRemoteDataSourceImpl(client: sl()),
      );
    }

    // Repository
    if (!sl.isRegistered<UserDomainRepository>()) {
      sl.registerLazySingleton<UserDomainRepository>(
        () => UserRepositoryImpl(remoteDataSource: sl()),
      );
    }

    // Use cases
    if (!sl.isRegistered<Login>()) {
      sl.registerLazySingleton(() => Login(repository: sl()));
    }
    if (!sl.isRegistered<Adduser>()) {
      sl.registerLazySingleton(() => Adduser(repository: sl()));
    }

    // Bloc
    if (!sl.isRegistered<AuthBloc>()) {
      sl.registerFactory(
        () => AuthBloc(
          loginUseCase: sl(),
          registerUseCase: sl(),
          tokenStorage: sl(),
        ),
      );
    }

    print('✅ Auth dependencies registered');
    print('✅ Dependency injection complete!');
  } catch (e, stackTrace) {
    print('❌ ERROR during dependency injection: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}