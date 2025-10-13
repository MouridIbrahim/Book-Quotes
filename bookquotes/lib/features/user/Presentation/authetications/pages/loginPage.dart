import 'dart:math';

import 'package:bookquotes/common/widgets/loginButton.dart';
import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:bookquotes/features/user/Presentation/authetications/pages/signupPage.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final double widgetWidth = min(
      400,
      MediaQuery.of(context).size.width * 0.8,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QuoteShare',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Find and share your favorite quotes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                color: AppColor.texyGreyColor,
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: widgetWidth,
              child: TextField(
                cursorColor: AppColor.textColorBlack,
                style: TextStyle(
                  color: AppColor.textColorBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  suffixIcon: null,
                  hintText: 'Email',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide(
                      color: AppColor.texyGreyColor,
                    ), // default border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColor.texyGreyColor,
                    ), // border color when enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColor.texyGreyColor,
                      width: 2,
                    ), // border color when focused
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: widgetWidth,
              child: TextFormField(
                cursorColor: AppColor.textColorBlack,
                style: TextStyle(
                  color: AppColor.textColorBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                controller: passwordController,
                obscureText: isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColor.texyGreyColor,
                    ), // default border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColor.texyGreyColor,
                    ), // border color when enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColor.texyGreyColor,
                      width: 2,
                    ), // border color when focused
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Loginbutton(
              onPressed: () {},
              text: 'Log In',
              width: widgetWidth,
              height: 70,
              color: AppColor.buttonColor,
            ),
            SizedBox(height: 20),
            Loginbutton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (Signuppage())),
                );
              },
              text: 'Sign Up',
              width: widgetWidth,
              height: 70,
              color: AppColor.textWhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
