import 'package:flutter/material.dart';
import 'package:howzatt_fun/pages/auth.dart';
import 'package:howzatt_fun/pages/entry.dart';
import 'dart:async';

import 'package:howzatt_fun/pages/homepage.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xffdb002e), accentColor: Colors.yellowAccent),
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        routes: {
          '/': (BuildContext context) => SplashScreen(),
          '/authpage': (BuildContext context) => AuthPage(),
          '/homepage': (BuildContext context) => HomePage(),
          '/entrypage': (BuildContext context) => EntryPage(),
        },
      ),
    );

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/authpage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xffdb002e)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/logo.jpeg'),
                      radius: 80.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      "Howzatt Fun",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Cricket Academy\n    For Everyone",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}