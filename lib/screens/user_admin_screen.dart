import 'package:flutter/material.dart';
import 'package:howzatt_fun/screens/all_users_screen.dart';
import 'package:howzatt_fun/screens/user_request_screen.dart';
import 'package:howzatt_fun/widgets/side_drawer.dart';

import '../scoped_models/main.dart';

class UserAdminPage extends StatelessWidget {
  final MainModel model;

  UserAdminPage(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideDrawer(
          model: model,
          selectedIndex: 3,
        ),
        appBar: AppBar(
          title: Text('Manage Users'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
                text: 'All Users',
              ),
              Tab(
                icon: Icon(Icons.create),
                text: 'User Requests',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            UserListPage(model),
            UserRequestPage(model),
          ],
        ),
      ),
    );
  }
}
