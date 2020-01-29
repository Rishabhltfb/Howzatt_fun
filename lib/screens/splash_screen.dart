import 'package:flutter/material.dart';
import 'dart:async';

import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(minutes: 3), vsync: this);
    animationController.repeat();
    Timer(Duration(seconds: 3), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = await preferences.get("token");
      Future.delayed(Duration.zero, () {
        if (token == null) {
          Navigator.pushReplacementNamed(context, "/auth");
        } else {
          Navigator.pushReplacementNamed(context, "/homepage");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
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
                      backgroundImage: AssetImage('assets/app_logo.png'),
                      radius: getViewportHeight(context) * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getViewportHeight(context) * 0.1),
                    ),
                    Text(
                      "HowzattFUN",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: getViewportHeight(context) * 0.06,
                          fontFamily: "Raleway",
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
                    AnimatedBuilder(
                      animation: animationController,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/cricket_ball.png',
                            height: getViewportHeight(context) * 0.1,
                            width: getViewportHeight(context) * 0.1,
                            fit: BoxFit.fill,
                          )),
                      builder: (BuildContext context, Widget _widget) {
                        return Transform.rotate(
                          angle: animationController.value * 500,
                          child: _widget,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getViewportHeight(context) * 0.15),
                    ),
                    Text(
                      "Cricket Academy\n    For Everyone",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: getViewportHeight(context) * 0.025,
                        fontFamily: "Ubuntu",
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
