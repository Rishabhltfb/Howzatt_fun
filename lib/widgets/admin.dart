import 'package:flutter/material.dart';

class AdminListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.verified_user),
      title: Text('Admin'),
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/admin');
      },
    );
  }
}
