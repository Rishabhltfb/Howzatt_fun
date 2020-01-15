import 'package:flutter/cupertino.dart';

class User {
  bool isAdmin;
  bool isEnabled;
  String token;
  String userId;
  String userEmail;
  String entryId;

  User({
    @required isAdmin,
    @required isEnabled,
    @required token,
    @required userId,
    @required userEmail,
    @required entryId,
  });
}
