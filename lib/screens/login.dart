import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:login_flutter/models/user.dart';
import 'package:login_flutter/screens/register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginUserState();
}

class LoginUserState extends State{
  bool visible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var url = 'http://10.0.2.2/login_system/login.php';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Stack(
                  children: [
                    Image(
                      image: new AssetImage("assets/login_bg.jpg"),
                      width: 500,
                      height: 500,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    Container(
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepPurple.withOpacity(0.8), Colors.indigo.withOpacity(0.8)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: new InputDecoration(
                                        filled: true,
                                        hintStyle: new TextStyle(color: Colors.white.withOpacity(0.5)),
                                        hintText: "Email",
                                        fillColor: Colors.black.withOpacity(0.3)),
                                    validator: (String value){
                                      if (value.isEmpty ||
                                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                              .hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: new InputDecoration(
                                        filled: true,
                                        hintStyle: new TextStyle(color: Colors.white.withOpacity(0.5)),
                                        hintText: "Password",
                                        fillColor: Colors.black.withOpacity(0.3)),
                                    validator: (String value){
                                      if (value.isEmpty) {
                                        return 'Password field cannot be empty';
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                  )),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(10),
                                        child: RaisedButton(
                                          onPressed: ()=>loginUser(context),
                                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                          color: Colors.white,
                                          splashColor: Colors.grey,
                                          child: const Text('Login',
                                              style: TextStyle(
                                                  fontSize: 20, color: Colors.black)),
                                        )
                                    ),
                                    GestureDetector(
                                        onTap: ()=>{},
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0,25,0,10),
                                          child: Text("Forgot Password ?",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )

                                    )

                                  ],
                                ),
                              ),
                              Visibility(
                                  visible: visible,
                                  child: Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: CircularProgressIndicator()
                                  )
                              )
                            ],
                          ),
                        ))
                  ]),

            ),
            Container(
              margin: EdgeInsets.fromLTRB(10,50,10, 10),
              child: Column(
                children: [
                  Text("Don't have an account ?"),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()))
                        },
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        color: Colors.indigo,
                        child: const Text('Register',
                            style: TextStyle(
                                fontSize: 20, color: Colors.white)),
                      )
                  )
                ],
              ),
            )
          ],
        ),
        ));
  }

  Future<void> loginUser(context) async{

    setState(() {
      visible = true;
    });

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email':emailController.text,
        'password':passwordController.text
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
      try{
        var user = User.fromJson(json.decode(response.body));
        await FlutterSession().set('userData', user);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }catch (e){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Invalid credentials given."),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

    } else {
      setState(() {
        visible = false;
      });
      throw Exception('Failed to load user');
    }
  }
}
