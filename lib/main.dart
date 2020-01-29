import 'package:flutter/material.dart';
import 'package:howzatt_fun/screens/auth_screen.dart';
import 'package:howzatt_fun/screens/entry_screen.dart';
import 'package:howzatt_fun/screens/homepage_screen.dart';
import 'package:howzatt_fun/screens/splash_screen.dart';
import 'package:howzatt_fun/screens/user_admin_screen.dart';
import 'package:howzatt_fun/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;
  @override
  void initState() {
    getAuth();
    _model.userSubject.listen((bool isAuthenticated) {
      Future.delayed(Duration.zero, () {
        setState(() {
          _isAuthenticated = isAuthenticated;
        });
      });
    });
    super.initState();
  }

  void getAuth() async {
    await _model.autoAuthenticate();
    await _model.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Color(0xffdb002e), accentColor: Colors.deepPurple),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (BuildContext context) => SplashPage(),
            '/homepage': (BuildContext context) =>
                !_isAuthenticated ? AuthPage(_model) : HomePage(_model),
            '/entrypage': (BuildContext context) =>
                !_isAuthenticated ? AuthPage(_model) : EntryPage(_model),
            '/admin': (BuildContext context) =>
                !_isAuthenticated ? AuthPage(_model) : UserAdminPage(_model),
          },
        ));
  }
}
