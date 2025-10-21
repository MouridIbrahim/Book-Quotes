import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.textWhiteColor,
        centerTitle:true,
        title: Text("Quotes"),
      )
      
    );
  }
}
