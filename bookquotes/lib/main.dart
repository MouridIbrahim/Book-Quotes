// main.dart
import 'package:bookquotes/core/config/theme/AppTheme.dart';
import 'package:bookquotes/features/user/Presentation/authetications/bloc/auth_bloc.dart';
import 'package:bookquotes/features/user/Presentation/authetications/bloc/injection_container.dart' as di;
import 'package:bookquotes/features/user/Presentation/splash/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.getIt<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.LightTheme,
        home: const SplashPage(),
      ),
    );
  }
}