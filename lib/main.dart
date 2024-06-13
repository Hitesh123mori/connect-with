import 'package:connectwith/screens/onboard_screens/splash_screen.dart';
import 'package:connectwith/utils/theme/colors.dart';
import 'package:flutter/material.dart' ;


late Size mq ;
void main(){
  runApp(MyApp()) ;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
    );
  }
}
