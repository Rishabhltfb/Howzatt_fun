import 'package:flutter/material.dart';

import '../widgets/logout.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  // static final String path = "lib/src/pages/lists/list2.dart";

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final primary = Color(0xffdb002e);
  final secondary = Color(0xfff29a94);

  final List<Map> schoolLists = [
    {
      "name": "Rishabh Sharma",
      "fee": "500",
      "contact": "38478342938",
      "overs": "8",
      "pic": "assets/user.jpg",
    },
    {
      "name": "Sarthak Gupta",
      "fee": "500",
      "contact": "38478342938",
      "overs": "10",
      "pic": "assets/user2.png",
    },
    {
      "name": "Rishabh Sharma",
      "fee": "500",
      "contact": "38478342938",
      "overs": "8",
      "pic": "assets/user.jpg",
    },
    {
      "name": "Sarthak Gupta",
      "fee": "500",
      "contact": "38478342938",
      "overs": "10",
      "pic": "assets/user2.png",
    },
  ];

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 140,
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
                  image: AssetImage(schoolLists[index]['pic']),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  schoolLists[index]['name'],
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
                    Text(schoolLists[index]['contact'],
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
                    Text(schoolLists[index]['overs'],
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
                      Icons.attach_money,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(schoolLists[index]['fee'],
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
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 145),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: schoolLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildListItem(context, index);
                    }),
              ),
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
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
                        onPressed: () => _scaffoldKey.currentState.openDrawer(),
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
                          Icons.filter_list,
                          color: Colors.white,
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
                          child: Icon(Icons.add, size: 50, color: secondary),
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
          ),
        ),
      ),
    );
  }
}
