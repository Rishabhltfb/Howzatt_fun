import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:howzatt_fun/helpers/flutter_icons.dart';
import 'package:howzatt_fun/scoped_models/main_scoped_model.dart';

class EntryListItem extends StatelessWidget {
  final MainModel model;
  final int index;
  final primary = Color(0xffdb002e);
  final secondary = Color(0xfff29a94);

  EntryListItem({@required this.model, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              blurRadius: 6.0,
              color: Colors.blueGrey,
            )
          ],
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: getViewportHeight(context) * 0.25,
        margin: EdgeInsets.symmetric(
            vertical: getViewportHeight(context) * 0.015,
            horizontal: getViewportWidth(context) * 0.08),
        padding: EdgeInsets.symmetric(
            vertical: getViewportHeight(context) * 0.015,
            horizontal: getViewportWidth(context) * 0.08),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: getViewportHeight(context) * 0.1,
                    height: getViewportWidth(context) * 0.2,
                    margin: EdgeInsets.only(
                        right: getViewportWidth(context) * 0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 3, color: primary),
                      image: DecorationImage(
                          image: AssetImage('assets/user2.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.entryList[index].name,
                          style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: getViewportHeight(context) * 0.025,
                              fontFamily: "Raleway"),
                        ),
                        SizedBox(
                          height: getViewportHeight(context) * 0.01,
                        ),
                        rowItem(context, Icons.phone,
                            model.entryList[index].contact),
                        SizedBox(
                          height: getViewportHeight(context) * 0.01,
                        ),
                        rowItem(
                          context,
                          FlutterIcon.soccer_ball,
                          model.entryList[index].overs.toInt().toString() +
                              ' Overs',
                        ),
                        SizedBox(
                          height: getViewportHeight(context) * 0.01,
                        ),
                        rowItem(context, FlutterIcon.rupee,
                            model.entryList[index].price.toStringAsFixed(0)),
                        SizedBox(
                          height: getViewportHeight(context) * 0.01,
                        ),
                        rowItem(
                          context,
                          Icons.verified_user,
                          model.entryList[index].entryCreator,
                        ),
                        SizedBox(
                          height: getViewportHeight(context) * 0.01,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(
                      left: getViewportWidth(context) * 0.05,
                      top: getViewportHeight(context) * 0.01),
                  alignment: Alignment.center,
                  child: rowItem(
                    context,
                    Icons.access_time,
                    model.entryList[index].datetime,
                  )),
            ]));
  }

  Widget rowItem(BuildContext context, IconData iconData, String text) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          color: secondary,
          size: getViewportHeight(context) * 0.024,
        ),
        SizedBox(
          width: getViewportHeight(context) * 0.008,
        ),
        Text(text,
            style: TextStyle(
                fontFamily: "Ubuntu",
                color: primary,
                fontSize: getViewportHeight(context) * 0.018,
                letterSpacing: .3)),
      ],
    );
  }
}
