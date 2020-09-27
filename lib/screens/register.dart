import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:login_flutter/screens/login.dart';
import 'package:login_flutter/theme.dart';

class RegisterScreen extends StatelessWidget {
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
                      height: 520,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    Container(
                        height: 500,
                        width: 520,
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
                                        hintText: "Full Name",
                                        fillColor: Colors.black.withOpacity(0.3)),
                                    validator: (String value){
                                      if (value.isEmpty) {
                                        return 'Name field is required';
                                      }
                                      return null;
                                    },
                                  )),
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
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: new InputDecoration(
                                        filled: true,
                                        hintStyle: new TextStyle(color: Colors.white.withOpacity(0.5)),
                                        hintText: "Mobile",
                                        fillColor: Colors.black.withOpacity(0.3)),
                                    validator: (String value){
                                      if (value.isEmpty ||
                                          !RegExp(r"^(?:[+0]9)?[0-9]{10}$")
                                              .hasMatch(value)) {
                                        return 'Please enter a valid number';
                                      }
                                      return null;
                                    },
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
                                      if (value.isEmpty || value.length < 5) {
                                        return 'Invalid password given';
                                      }
                                      return null;
                                    },
                                  )),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(10),

                                  child: RaisedButton(
                                    onPressed: () => {},
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    color: Colors.white,
                                    splashColor: Colors.grey,
                                    child: const Text('Register',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
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
                  Text("Already have an account ?"),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()))
                        },
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        color: Colors.indigo,
                        child: const Text('Login',
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
}
