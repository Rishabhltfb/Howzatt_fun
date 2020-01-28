import 'package:flutter/material.dart';

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
    return ListTile(
      leading: Icon(
        tileIcon,
      ),
      dense: true,
      title: Text(
        tileName,
      ),
      selected: isSelected,
      onTap: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
    );
  }
}
