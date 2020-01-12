import 'package:flutter/cupertino.dart';

class User {
  bool isAdmin;
  String name;
  String userId;
  String userEmail;

  User(
    @required isAdmin,
    @required name,
    @required userId,
    @required userEmail,
  );
}
