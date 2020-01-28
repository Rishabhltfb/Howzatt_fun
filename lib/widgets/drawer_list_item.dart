import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';

class DrawerListItem extends StatelessWidget {
  final String tileName;
  final IconData tileIcon;
  final String routeName;
  final bool isSelected;

  DrawerListItem(
      {@required this.tileIcon,
      @required this.tileName,
      @required this.routeName,
      @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, routeName);
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
