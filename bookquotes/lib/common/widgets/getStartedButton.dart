import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:flutter/material.dart';

class Getstartedbutton extends StatelessWidget {
 final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  const Getstartedbutton({super.key, required this.onPressed, required this.text, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(onPressed: onPressed, child: Text( text,style: TextStyle(color:AppColor.textColorBlack)),style: ElevatedButton.styleFrom(
       minimumSize: Size(width, height),
                      backgroundColor: AppColor.buttonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
    ),);
  }
}
