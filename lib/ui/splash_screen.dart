import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/ui/home.dart';
import 'package:splashscreen/splashscreen.dart';

class Walkthrough extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experimenting Flutter',
      theme: ThemeData(
        primarySwatch: Colors.purple, fontFamily: 'QuickSand'
      ),
      home: splashScreen(),
      debugShowCheckedModeBanner: false, 
     // debugShowMaterialGrid: true,
    );
  }
}

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: Home(title: 'Flutter Walkthrough'),
        title: Text('Flutter Walkthrough',
        style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.0
      ),),
      image: new Image.asset('assets/images/icon/custom-icon.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 80.0,
      loaderColor: Colors.purple
    );
  }
}