import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:howzatt_fun/scoped_models/main_scoped_model.dart';
import 'package:howzatt_fun/widgets/logout_dialog.dart';

class DrawerListItem extends StatelessWidget {
  final String tileName;
  final IconData tileIcon;
  final String routeName;
  final bool isSelected;
  final MainModel mainModel;

  DrawerListItem(
      {@required this.tileIcon,
      @required this.tileName,
      @required this.routeName,
      @required this.mainModel,
      @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          if (routeName != "/logout") {
            Navigator.pushReplacementNamed(context, routeName);
          } else {
            showLogoutDialog(context: context, mainModel: mainModel);
          }
        },
        splashColor: Colors.red,
        child: Container(
            alignment: Alignment.center,
            height: getViewportHeight(context) * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  tileIcon,
                  color: isSelected ? Colors.red : Colors.black,
                ),
                SizedBox(
                  width: getViewportWidth(context) * 0.04,
                ),
                Text(
                  tileName,
                  style:
                      TextStyle(color: isSelected ? Colors.red : Colors.black),
                ),
              ],
            )));
  }
}
