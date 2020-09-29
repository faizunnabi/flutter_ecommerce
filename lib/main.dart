import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_flutter/screens/login.dart';
import 'package:login_flutter/theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(primaryColor: Colors.indigo),
      home: new SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child: Image(
          image: AssetImage("assets/logo.png"),
          width: 150,
          height: 150,
          alignment: Alignment.center,
        ),
      )
    );
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
}


