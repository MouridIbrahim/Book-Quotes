import 'package:bookquotes/core/config/theme/AppTheme.dart';
import 'package:bookquotes/features/user/Presentation/pages/Getstartedone.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.LightTheme,
      home:  Getstartedone(),
    );
  }
}
