import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:howzatt_fun/widgets/entry_list_item.dart';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final primary = Color(0xffdb002e);
  final secondary = Color(0xfff29a94);

 

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
                      onRefresh: () async {
                        await widget.model.fetchEntries();
                      },
                      child: ListView.builder(
                          itemCount: model.entryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return EntryListItem(index: index,model: model,);
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
                            Navigator.pushReplacementNamed(context, '/entrypage');
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
