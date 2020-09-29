import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:login_flutter/models/user.dart';
import 'package:carousel_slider/carousel_slider.dart';


import 'login.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State{
  int _current = 2;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [BottomNavigationBarItem(icon: new Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: new Icon(Icons.grid_view), label: 'Categories'),
          BottomNavigationBarItem(
              icon: new Stack(
                  children: <Widget>[
                    new Icon(Icons.shopping_cart),
                    new Positioned(
                      top:0,
                      right: 0,
                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: new Text(
                          _current.toString(),
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ]
              ),
              label: 'Cart'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
      body: FutureBuilder(
        future:FlutterSession().get('userData'),
        builder: (context,snap){

          if(snap.hasData){
            return Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      child: CarouselSlider(
                        options: CarouselOptions(height: 200.0),
                        items: [1,2,3,4,5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.indigo
                                  ),
                                  child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ]
            );
          }else{
            return LoginScreen();
          }
        },
      ),
    );
  }
}