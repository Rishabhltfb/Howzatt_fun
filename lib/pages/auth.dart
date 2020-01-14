import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/auth.dart';
import '../scoped_models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final MainModel _model = MainModel();
  bool formVisible;
  AuthMode _authMode;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _authMode = AuthMode.Login;
  }

  final TextEditingController _passwordTextController = TextEditingController();

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
            onSaved: (String value) {
              _formData['email'] = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
            controller: _passwordTextController,
            onSaved: (String value) {
              _formData['password'] = value;
            },
          ),
          _authMode == AuthMode.Login ? null : const SizedBox(height: 10.0),
          _authMode == AuthMode.Login
              ? null
              : TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String value) {
                    if (_passwordTextController.text != value) {
                      return 'Password do not match.';
                    }
                  },
                ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Color(0xffdb002e),
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(_authMode == AuthMode.Login ? "Login" : "Signup"),
            onPressed: () {
              // _submitForm();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/auth_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black54,
            child: Column(
              children: <Widget>[
                const SizedBox(height: kToolbarHeight + 40),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Welcome to this awesome cricket app. \n You are awesome !",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Color(0xffdb002e),
                        textColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Login"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _authMode = AuthMode.Login;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.grey.shade700,
                        textColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Signup"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _authMode = AuthMode.Signup;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
                const SizedBox(height: 40.0),
                OutlineButton.icon(
                  borderSide: BorderSide(color: Color(0xffdb002e)),
                  color: Color(0xffdb002e),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  icon: Icon(FontAwesomeIcons.user),
                  label: Text("Login as Admin"),
                  onPressed: () {},
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: (!formVisible)
                ? null
                : Container(
                    child: Form(
                      child: Container(
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  textColor: _authMode == AuthMode.Login
                                      ? Colors.white
                                      : Colors.black,
                                  color: _authMode == AuthMode.Login
                                      ? Color(0xffdb002e)
                                      : Colors.white,
                                  child: Text("Login"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    setState(() {
                                      _authMode = AuthMode.Login;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                RaisedButton(
                                  textColor: _authMode == AuthMode.Signup
                                      ? Colors.white
                                      : Colors.black,
                                  color: _authMode == AuthMode.Signup
                                      ? Color(0xffdb002e)
                                      : Colors.white,
                                  child: Text("Signup"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    setState(() {
                                      _authMode = AuthMode.Signup;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      formVisible = false;
                                    });
                                  },
                                )
                              ],
                            ),
                            Container(
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: _buildForm(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }
}
