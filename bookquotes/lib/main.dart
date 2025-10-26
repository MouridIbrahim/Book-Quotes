import 'package:bookquotes/core/config/theme/AppTheme.dart';
import 'package:bookquotes/core/injection/injection_container.dart' as di;

import 'package:bookquotes/features/user/Presentation/splash/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookquotes/features/user/Presentation/authetications/bloc/auth_bloc.dart';
import 'package:bookquotes/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // This now registers EVERYTHING
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AuthBloc>()..add(CheckAuthEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Quotes',
        theme: AppTheme.LightTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const MainScreen();
            }
            return const SplashPage();
          },
        ),
      ),
    );
  }
}