import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:howzatt_fun/helpers/flutter_icons.dart';
import 'package:howzatt_fun/scoped_models/main.dart';
import 'package:howzatt_fun/widgets/drawer_list_item.dart';

class SideDrawer extends StatefulWidget {
  final MainModel model;
  final int selectedIndex;

  SideDrawer({@required this.model, @required this.selectedIndex});

  @override
  State<StatefulWidget> createState() {
    return _SideDrawerState(selectedIndex: selectedIndex);
  }
}

class _SideDrawerState extends State<SideDrawer> {
  final int selectedIndex;

  _SideDrawerState({@required this.selectedIndex});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            width: getViewportWidth(context) * 0.6,
            child: Drawer(
              elevation: 5,
              child: ListView(
                children: <Widget>[
                  Container(
                      height: getViewportHeight(context) * 0.25,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[Colors.cyan, Color(0xff5614B0)],
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 3,
                            )
                          ],
                          color: Colors.red,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "HowzattFUN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700,
                                  fontSize: getViewportHeight(context) * 0.025),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  top: getViewportHeight(context) * 0.02),
                              child: Image.asset(
                                "assets/app_logo.png",
                                fit: BoxFit.fill,
                                height: getViewportHeight(context) * 0.15,
                              ),
                            )
                          ],
                        ),
                      )),
                  DrawerListItem(
                    tileIcon: FlutterIcon.list,
                    tileName: "Entries",
                    routeName: "/homepage",
                    isSelected: selectedIndex == 1 ? true : false,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  DrawerListItem(
                    tileIcon: Icons.edit,
                    tileName: "Add Entry",
                    routeName: "/entrypage",
                    isSelected: selectedIndex == 2 ? true : false,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  widget.model.authenticatedUser.isAdmin
                      ? DrawerListItem(
                          tileIcon: Icons.verified_user,
                          tileName: "Admin Panel",
                          routeName: "/admin",
                          isSelected: selectedIndex == 3 ? true : false,
                        )
                      : Container(),
                  Divider(
                    thickness: 1,
                  ),
                  DrawerListItem(
                    tileIcon: Icons.settings_power,
                    tileName: "Log Out",
                    routeName: "/logout",
                    isSelected: false,
                  ),
                ],
              ),
            )));
  }
}
