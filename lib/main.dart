import 'package:flutter/material.dart';
import 'package:hm/screens/hm_main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFf7f7f7)),
      home:  HmMainScreen(),
    );
  }
}