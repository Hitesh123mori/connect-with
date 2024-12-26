import 'package:connectwith/screens/onboard_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' ;
import 'firebase_options.dart';

late Size mq ;
void main()async{

  WidgetsFlutterBinding.ensureInitialized() ;
  await _intializeFirebase() ;
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
      home: SplashScreen() ,
      ) ;
  }
}

_intializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}