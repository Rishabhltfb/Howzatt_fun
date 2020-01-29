import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main_scoped_model.dart';

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
      icon: Icon(
        Icons.done,
        size: getViewportHeight(context) * 0.035,
      ),
      onPressed: () {
        updateUser(model.disabledUsers[index].entryId);
      },
    );
  }

  void updateUser(String entryId) {
    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return null;
      },
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: ScopedModelDescendant<MainModel>(
                  builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return AlertDialog(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      title: Text('Update Account'),
                      content: Text('Do you want to enable this account?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            model.enableUser(entryId);
                          },
                        ),
                      ],
                    );
                  },
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.disabledUsers.length == 0
                ? noUser(context)
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              radius: getViewportHeight(context) * 0.033,
                              backgroundImage: AssetImage('assets/user.jpg'),
                            ),
                            title: Container(
                              child: Text(
                                model.disabledUsers[index].username,
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize:
                                        getViewportHeight(context) * 0.024,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: getViewportHeight(context) * 0.01),
                            ),
                            subtitle: Text(
                              model.disabledUsers[index].isEnabled
                                  ? 'Status: Enabled'
                                  : 'Status: Disabled',
                              style: TextStyle(fontFamily: "Ubuntu"),
                            ),
                            trailing: _buildEditButton(context, index, model),
                          ),
                          Divider(),
                        ],
                      );
                    },
                    itemCount: model.disabledUsers.length,
                  );
      },
    );
  }

  Widget noUser(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getViewportHeight(context)*0.02),
      alignment: Alignment.center,
      child: Text(
        "There are no user requests currently.",
        style: TextStyle(
          fontFamily: "Raleway",
          fontSize: getViewportHeight(context) * 0.03,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
