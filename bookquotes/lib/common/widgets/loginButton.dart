import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:flutter/material.dart';

class Loginbutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final Color color;
  const Loginbutton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(text, style: TextStyle(color: AppColor.textColorBlack, fontSize: 26)),
    );
  }
}
