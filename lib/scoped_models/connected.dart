import 'dart:convert';
import 'dart:async';

import '../models/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ConnectedModel extends Model {
  List<User> _userList = [];
  User _authenticatedUser;
  bool _isLoading = false;
}

class UserModel extends ConnectedModel {
  User get authenticatedUser {
    return _authenticatedUser;
  }

  List<User> get userList {
    return List.from(_userList);
  }

  List<User> get disabledUsers {
    return _userList.where((User user) => !user.isEnabled).toList();
  }

  List<User> get userRequests {
    return _userList.where((User user) => !user.isEnabled).toList();
  }

  void setAuthenticatedUser({String token, String email, String userId}) {
    User currentUser = _userList.firstWhere((User user) {
      return user.userId == userId;
    });
    _authenticatedUser = currentUser;
    _authenticatedUser.token = token;
  }

  Future<Null> fetchUsers() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://howzatt-fun.firebaseio.com/users.json')
        .then<Null>((http.Response response) {
      final List<User> fetchedUserList = [];
      final Map<String, dynamic> userListData = json.decode(response.body);
      if (userListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      userListData.forEach((String entryId, dynamic userData) {
        final User user = User(
          entryId: entryId,
          isAdmin: userData['isAdmin'],
          isEnabled: userData['isEnabled'],
          token: '',
          userId: userData['userId'],
          userEmail: userData['email'],
        );
        fetchedUserList.add(user);
      });
      _userList = fetchedUserList;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> addUserEntry(String email, String userId) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> userEntry = {
      'isAdmin': false,
      'isEnabled': false,
      'userId': userId,
      'email': email,
    };

    try {
      final http.Response response = await http.post(
          'https://howzatt-fun.firebaseio.com/users.json',
          body: json.encode(userEntry));

      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final User newUser = User(
        isAdmin: false,
        isEnabled: false,
        userEmail: email,
        token: '',
        userId: userId,
        entryId: json.decode(response.body)['name'],
      );
      _userList.add(newUser);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> enableUser(String entryId) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'isEnabled': true,
    };
    return http
        .patch('https://howzatt-fun.firebaseio.com/users/${entryId}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      fetchUsers();
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
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
      await addUserEntry(email, json.decode(response.body)['localId']);
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded';
      setAuthenticatedUser(
        token: responseData['idToken'],
        email: email,
        userId: responseData['localId'],
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
