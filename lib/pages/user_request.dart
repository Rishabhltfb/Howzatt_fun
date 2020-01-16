import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class UserRequestPage extends StatefulWidget {
  final MainModel model;

  UserRequestPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _UserRequestPageState();
  }
}

class _UserRequestPageState extends State<UserRequestPage> {
  @override
  initState() {
    widget.model.fetchUsers();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.done),
      onPressed: () {
        model.enableUser(model.disabledUsers[index].entryId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.disabledUsers[index].userEmail),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  // model.selectProduct(model.allProducts[index].id);
                  // model.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  print('Swiped start to end');
                } else {
                  print('Other Swiping');
                }
              },
              background: Container(color: Colors.red),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/user.jpg'),
                    ),
                    title: Text(model.disabledUsers[index].userEmail),
                    subtitle: Text(model.disabledUsers[index].isEnabled
                        ? 'Enabled'
                        : 'Not Enabled'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.disabledUsers.length,
        );
      },
    );
  }
}
