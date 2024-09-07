import 'package:flutter/material.dart';
import 'package:grocery_app/feature/auth/presentation/view/splah_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      //MainPage(),

      SplahView()
    );
  }
}
