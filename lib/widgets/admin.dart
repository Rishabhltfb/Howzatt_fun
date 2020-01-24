import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class AdminListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return !model.authenticatedUser.isAdmin
            ? Container()
            : ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Admin'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/admin');
                },
              );
      },
    );
  }
}
