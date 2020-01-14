import 'dart:convert';
import 'dart:async';

import '../models/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ConnectedModel extends Model {
  User _authenticatedUser;
}

class UserModel extends ConnectedModel {
  User get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDlrjs7x7jXzLRBmQGdYoLmWkgSbdGKXzU',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDlrjs7x7jXzLRBmQGdYoLmWkgSbdGKXzU',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded';
      _authenticatedUser = User(
        isAdmin: false,
        userId: responseData['localId'],
        userEmail: email,
        token: responseData['idToken'],
      );
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'This password is invalid';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email is already taken';
    }

    return {'success': !hasError, 'message': message};
  }

  void logout() {
    _authenticatedUser = null;
  }
}
