import 'package:flutter/material.dart';
import 'package:howzatt_fun/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/logout.dart';

class RequestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestPageState();
  }
}

class _RequestPageState extends State<RequestPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final primary = Color(0xffdb002e);
  final secondary = Color(0xfff29a94);

  Widget _buildListItem(BuildContext context, int index, MainModel model) {
    return Container(
        child: Center(
      child: Text('Hello'),
    ));
    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(25),
    //     color: Colors.white,
    //   ),
    //   width: double.infinity,
    //   height: 140,
    //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Container(
    //         width: 80,
    //         height: 80,
    //         margin: EdgeInsets.only(right: 15),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(50),
    //           border: Border.all(width: 3, color: primary),
    //           image: DecorationImage(
    //               image: AssetImage(schoolLists[index]['pic']),
    //               fit: BoxFit.fill),
    //         ),
    //       ),
    //       Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               schoolLists[index]['name'],
    //               style: TextStyle(
    //                   color: primary,
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 18),
    //             ),
    //             SizedBox(
    //               height: 7,
    //             ),
    //             Row(
    //               children: <Widget>[
    //                 Icon(
    //                   Icons.phone,
    //                   color: secondary,
    //                   size: 20,
    //                 ),
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text(schoolLists[index]['contact'],
    //                     style: TextStyle(
    //                         color: primary, fontSize: 13, letterSpacing: .3)),
    //               ],
    //             ),
    //             SizedBox(
    //               height: 7,
    //             ),
    //             Row(
    //               children: <Widget>[
    //                 Icon(
    //                   Icons.check_circle,
    //                   color: secondary,
    //                   size: 20,
    //                 ),
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text(schoolLists[index]['overs'],
    //                     style: TextStyle(
    //                         color: primary, fontSize: 13, letterSpacing: .3)),
    //               ],
    //             ),
    //             SizedBox(
    //               height: 7,
    //             ),
    //             Row(
    //               children: <Widget>[
    //                 Icon(
    //                   Icons.attach_money,
    //                   color: secondary,
    //                   size: 20,
    //                 ),
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text(schoolLists[index]['fee'],
    //                     style: TextStyle(
    //                         color: primary, fontSize: 13, letterSpacing: .3)),
    //               ],
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xfff0f0f0),
          drawer: _buildSideDrawer(context),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.only(top: 145),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: model.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildListItem(context, index, model);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
