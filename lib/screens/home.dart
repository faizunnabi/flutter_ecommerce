import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:login_flutter/models/user.dart';

import 'login.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
        future:FlutterSession().get('userData'),
        builder: (context,snap){

          if(snap.hasData){
            return Center(
                child:Text("Hello "+snap.data["name"].toString())
            );
          }else{
            return LoginScreen();
          }
        },
      ),
    );
  }


}