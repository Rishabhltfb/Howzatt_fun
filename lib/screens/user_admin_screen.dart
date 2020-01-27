import 'package:flutter/material.dart';
import 'package:howzatt_fun/screens/all_users_screen.dart';
import 'package:howzatt_fun/screens/user_request_screen.dart';

import '../scoped_models/main.dart';
import '../widgets/logout.dart';

class UserAdminPage extends StatelessWidget {
  final MainModel model;

  UserAdminPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Add Entry'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/entrypage');
            },
          ),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Users'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'User Requests',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'All Users',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            UserRequestPage(model),
            UserListPage(model),
          ],
        ),
      ),
    );
  }
}
