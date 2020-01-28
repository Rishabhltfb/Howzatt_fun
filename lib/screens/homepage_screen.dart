import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:howzatt_fun/widgets/side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage(this.model);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    Future.delayed(Duration.zero, () {
      _refreshIndicatorKey.currentState.show();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      drawer: SideDrawer(
        model: widget.model,
        selectedIndex: 1,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
            return Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: getViewportHeight(context) * 0.175),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.red,
                      onRefresh: () async {
                        await widget.model.fetchEntries();
                      },
                      child: ListView.builder(
                          itemCount: model.entryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildListItem(context, index, model);
                          }),
                    )),
                Container(
                  height: getViewportHeight(context) * 0.168,
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
                    padding: EdgeInsets.symmetric(
                        horizontal: getViewportWidth(context) * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          splashColor: Colors.red,
                          onPressed: () =>
                              _scaffoldKey.currentState.openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Entries",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getViewportHeight(context) * 0.04,
                            fontFamily: "Ubuntu",
                          ),
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
                        height: getViewportHeight(context) * 0.13,
                      ),
                      Center(
                        child: FloatingActionButton(
                          splashColor: Colors.red,
                          backgroundColor: Colors.white,
                          elevation: 5,
                          child: Icon(Icons.add,
                              size: getViewportHeight(context) * 0.05,
                              color: primary),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/entrypage');
                          },
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
    );
  }
}
