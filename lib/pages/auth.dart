import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/auth.dart';
import '../scoped_models/main.dart';

class AuthPage extends StatefulWidget {
  final MainModel model;
  AuthPage(this.model);
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool formVisible;
  AuthMode _authMode;

  @override
  void initState() {
    super.initState();
    widget.model.fetchUsers();
    formVisible = false;
    _authMode = AuthMode.Login;
  }

  final TextEditingController _passwordTextController = TextEditingController();

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'username': null,
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
            _authMode == AuthMode.Login
                ? Container()
                : const SizedBox(height: 10.0),
            _authMode == AuthMode.Login
                ? Container()
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
                      return null;
                    },
                  ),
            const SizedBox(height: 10.0),
            _authMode == AuthMode.Login
                ? Container()
                : const SizedBox(height: 10.0),
            _authMode == AuthMode.Login
                ? Container()
                : TextFormField(
                    decoration: InputDecoration(
                      hintText: "User Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Username can not be left empty.';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _formData['username'] = value;
                    },
                  ),
            const SizedBox(height: 10.0),
            RaisedButton(
              color: Color(0xffdb002e),
              textColor: Colors.white,
              elevation: 10,
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return model.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(_authMode == AuthMode.Login ? "Login" : "Signup");
                },
              ),
              onPressed: () {
                _submitForm();
              },
            ),
          ],
        ));
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await widget.model.authenticate(_formData['email'],
        _formData['password'], _formData['username'], _authMode);
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/homepage');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(successInformation['message'] !=
                    'Your Account request has been sent successfully.'
                ? 'An error has Occurred'
                : 'Message'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
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
                const SizedBox(height: 60.0),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: (!formVisible)
                ? null
                : Container(
                    child: Form(
                      key: _formKey,
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
