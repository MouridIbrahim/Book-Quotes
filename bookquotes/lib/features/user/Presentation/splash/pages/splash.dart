import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:bookquotes/features/user/Presentation/pages/Getstartedone.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.5,
              child: Image(
                image: AssetImage('assets/images/image1.png'),
                width: 150,
                height: 150,
                  
              ),
            ),

            Opacity(
              opacity: 0.6,
              child: Text(
                'Book Quotes',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Opacity(
              opacity: 0.5,
              child: Text(
                'Discover and Share Words that Inspire ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.texyGreyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Getstartedone(),
      ),
    );
  }
}
