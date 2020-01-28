import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';
import 'package:intl/intl.dart';

import '../api/keys.dart';
import '../models/auth.dart';
import '../models/entry.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ConnectedModel extends Model {
  List<User> _userList = [];
  List<Entry> _entryList = [];
  User _authenticatedUser;
  bool _isLoading = false;
}

class EntryModel extends ConnectedModel {
  List<Entry> get entryList {
    return List.from(_entryList.reversed);
  }

  Future<Null> fetchEntries() async {
    _isLoading = true;
    notifyListeners();
    return await http
        .get(
            'https://howzatt-fun.firebaseio.com/entries.json?auth=${_authenticatedUser.token}')
        .then<Null>((http.Response response) {
      final List<Entry> fetchedEntryList = [];
      final Map<String, dynamic> entryListData = json.decode(response.body);
      if (entryListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      entryListData.forEach((String id, dynamic entryData) {
        final Entry entry = Entry(
          id: id,
          name: entryData['name'],
          contact: entryData['contact'],
          price: entryData['price'],
          overs: entryData['overs'],
          datetime: entryData['datetime'],
          entryCreator: entryData['entryCreator'],
        );
        fetchedEntryList.add(entry);
      });
      _entryList = fetchedEntryList;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> addEntry(
      {String name, String contact, double price, double overs}) async {
    _isLoading = true;
    notifyListeners();
    final DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm a, EEE, d MMM yyyy').format(now);

    final Map<String, dynamic> entryData = {
      'name': name,
      'contact': contact,
      'price': price,
      'overs': overs,
      'datetime': formattedDate,
      'entryCreator': _authenticatedUser.username,
    };
    try {
      final http.Response response = await http.post(
          'https://howzatt-fun.firebaseio.com/entries.json?auth=${_authenticatedUser.token}',
          body: json.encode(entryData));

      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Entry newEntry = Entry(
        id: responseData['name'],
        name: name,
        contact: contact,
        price: price,
        overs: overs,
        datetime: formattedDate,
        entryCreator: _authenticatedUser.username,
      );
      _entryList.add(newEntry);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}

class UserModel extends ConnectedModel {
  final key = ApiKeys.apiKey;
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

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

  void setAuthenticatedUser({String token, String userId}) {
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
      _isLoading = false;
      notifyListeners();

      userListData.forEach((String entryId, dynamic userData) {
        final User user = User(
          username: userData['username'],
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
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> addUserEntry(
      String email, String userId, String username, String token) async {
    final Map<String, dynamic> userEntry = {
      'username': username,
      'isAdmin': false,
      'isEnabled': false,
      'userId': userId,
      'email': email,
    };

    try {
      final http.Response response = await http.post(
          'https://howzatt-fun.firebaseio.com/users.json?auth=${token}',
          body: json.encode(userEntry));

      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      }

      final User newUser = User(
        username: username,
        isAdmin: false,
        isEnabled: false,
        userEmail: email,
        token: '',
        userId: userId,
        entryId: json.decode(response.body)['name'],
      );
      _userList.add(newUser);
      return true;
    } catch (error) {
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
        .patch(
            'https://howzatt-fun.firebaseio.com/users/${entryId}.json?auth=${_authenticatedUser.token}',
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

  Future<bool> disableUser(String entryId) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'isEnabled': false,
    };
    return http
        .patch(
            'https://howzatt-fun.firebaseio.com/users/${entryId}.json?auth=${_authenticatedUser.token}',
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

  Future<Map<String, dynamic>> authenticate(
      String email, String password, String username,
      [AuthMode mode = AuthMode.Login]) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    _isLoading = true;
    notifyListeners();
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${key}',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${key}',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        await addUserEntry(email, json.decode(response.body)['localId'],
            username, json.decode(response.body)['idToken']);
      }
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      setAuthenticatedUser(
        token: responseData['idToken'],
        userId: responseData['localId'],
      );
    }
    if (mode == AuthMode.Login &&
        !responseData.containsKey('error') &&
        _authenticatedUser.isEnabled) {
      setAuthTimeout();
      _userSubject.add(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('refreshToken', responseData['refreshToken']);
      prefs.setString('userId', responseData['localId']);
    }
    if (responseData.containsKey('idToken')) {
      if (mode == AuthMode.Signup) {
        _isLoading = false;
        notifyListeners();
        message = 'Your account request has been sent successfully.';
        return {'success': !hasError, 'message': message};
      }
      setAuthenticatedUser(
        token: responseData['idToken'],
        userId: responseData['localId'],
      );
      _authenticatedUser.isEnabled ? hasError = false : hasError = true;
      _authenticatedUser.isEnabled
          ? message = 'Authentication succeeded'
          : message = 'Admin has not enabled your account yet.';
      _authenticatedUser.isEnabled
          ? _userSubject.add(true)
          : _userSubject.add(false);
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'This password is invalid';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email is already taken';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void setAuthTimeout() {
    _authTimer = Timer(Duration(seconds: 3000), refreshAuthToken);
  }

  void autoAuthenticate() async {
    _isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      setAuthTimeout();
      await refreshAuthToken();
      token = prefs.getString('token');
      notifyListeners();
      return;
    }
    final String userId = prefs.getString('userId');
    await fetchUsers();
    setAuthenticatedUser(token: token, userId: userId);
    _userSubject.add(true);
    setAuthTimeout();
    notifyListeners();
  }

  void refreshAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String refreshToken = await prefs.get("refreshToken");
    await http
        .post(
            "https://securetoken.googleapis.com/v1/token?key=${key.toString()}",
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: "grant_type=refresh_token&refresh_token=$refreshToken")
        .then((value) async {
      if (value.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(value.body);
        await prefs.setString("token", responseBody["id_token"]);
        await prefs.setString("refreshToken", responseBody["refresh_token"]);
      } else {
        print("Refresh Token Error: ${value.body}");
      }
    }).catchError((error) {
      print("Refresh Token Error: $error");
    });
  }

  void logout() async {
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }
}

class UtilityModel extends ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
