import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:howzatt_fun/scoped_models/main.dart';

void showLogoutDialog(
    {@required BuildContext context, @required MainModel mainModel}) {
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
                child: AlertDialog(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "OK",
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        mainModel.logout();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                  title: Text("Log Out"),
                  content: Container(
                    width: getViewportWidth(context),
                    child: Text("Are you sure want to log out?"),
                    padding: EdgeInsets.all(5),
                  ),
                )));
      });
}
