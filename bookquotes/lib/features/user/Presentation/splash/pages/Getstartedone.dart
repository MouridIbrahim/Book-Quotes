

import 'package:bookquotes/common/widgets/getStartedButton.dart';
import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:bookquotes/features/user/Presentation/splash/pages/Getstartedtwo.dart';
import 'package:flutter/material.dart';

class Getstartedone extends StatefulWidget {
  const Getstartedone({super.key});

  @override
  State<Getstartedone> createState() => _GetstartedoneState();
}

class _GetstartedoneState extends State<Getstartedone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/imagetwo.jpg'),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),

          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 25),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    'Discover the power of \nwords',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Explore a vast collection of inspiring quotes from renowned authors, thinkers, and leaders',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: AppColor.textWhiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Getstartedbutton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Getstartedtwo()),
                      );
                    },
                    text: 'Next',
                    width: 200,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}