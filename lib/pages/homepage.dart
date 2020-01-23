import 'package:flutter/material.dart';
import 'package:howzatt_fun/widgets/admin.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../widgets/logout.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage(this.model);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.model.fetchEntries();
    super.initState();
  }

  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final primary = Color(0xffdb002e);
  final secondary = Color(0xfff29a94);

  Widget _buildListItem(BuildContext context, int index, MainModel model) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            blurRadius: 5.0,
            color: Colors.blueGrey,
          )
        ],
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 195,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: primary),
              image: DecorationImage(
                  image: AssetImage('assets/user2.png'), fit: BoxFit.fill),
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
                      fontSize: 18),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(model.entryList[index].contact,
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        model.entryList[index].overs.toInt().toString() +
                            '  overs',
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      " \u20B9",
                      style: TextStyle(color: secondary, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(model.entryList[index].price.toString(),
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(model.entryList[index].datetime,
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.verified_user,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(model.entryList[index].entryCreator,
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
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
          widget.model.authenticatedUser.isAdmin ? Divider() : Container(),
          widget.model.authenticatedUser.isAdmin
              ? AdminListTile()
              : Container(),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      drawer: _buildSideDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 145),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: model.entryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildListItem(context, index, model);
                        }),
                  ),
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 10.0,
                          )
                        ],
                        color: primary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () =>
                                _scaffoldKey.currentState.openDrawer(),
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Entries",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.menu,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 110,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: FloatingActionButton(
                              highlightElevation: 5,
                              backgroundColor: Colors.white,
                              elevation: 10,
                              child: Icon(Icons.add, size: 50, color: primary),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/entrypage');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
