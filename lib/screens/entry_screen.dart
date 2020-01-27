import 'package:flutter/material.dart';
import 'package:howzatt_fun/helpers/dimensions.dart';
import 'package:howzatt_fun/helpers/flutter_icons.dart';
import 'package:howzatt_fun/widgets/admin.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../models/entry_model.dart';
import '../widgets/logout.dart';

class EntryPage extends StatefulWidget {
  final MainModel model;
  EntryPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _EntryPageState();
  }
}

class _EntryPageState extends State<EntryPage> with WidgetsBindingObserver {
  final Map<String, dynamic> _formData = {
    'name': null,
    'overs': null,
    'price': null,
    'contact': null,
    'userId': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final primary = Color(0xffdb002e);
  final secondary = Color(0xfff29a94);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Homepage'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/homepage');
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

  Widget _buildNameTextField(Entry entry) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: getViewportHeight(context) * 0.02,
            horizontal: getViewportWidth(context) * 0.03),
        child: TextFormField(
          style: TextStyle(
              fontSize: getViewportHeight(context) * 0.025,
              fontFamily: "Ubuntu",
              color: Colors.blue),
          decoration: InputDecoration(
            alignLabelWithHint: false,
            prefixIcon: Icon(
              Icons.people,
              color: Colors.red,
              size: getViewportHeight(context) * 0.03,
            ),
            labelText: 'Entry Name',
            labelStyle: TextStyle(
                fontFamily: "Raleway",
                color: Colors.black,
                fontWeight: FontWeight.w600),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          validator: (String value) {
            if (value.isEmpty || value.length < 3) {
              return 'Name is required and should be 3+ character long.';
            }
            return null;
          },
          onChanged: (String value) {
            _formData['name'] = value;
          },
          onSaved: (String value) {
            _formData['name'] = value;
          },
        ));
  }

  Widget _buildContactTextField(Entry entry) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: getViewportHeight(context) * 0.02,
            horizontal: getViewportWidth(context) * 0.03),
        child: TextFormField(
          style: TextStyle(
              fontSize: getViewportHeight(context) * 0.025,
              fontFamily: "Ubuntu",
              color: Colors.blue),
          decoration: InputDecoration(
            alignLabelWithHint: false,
            prefixIcon: Icon(
              Icons.phone_android,
              color: Colors.red,
              size: getViewportHeight(context) * 0.03,
            ),
            labelText: 'Contact Number',
            labelStyle: TextStyle(
                fontFamily: "Raleway",
                color: Colors.black,
                fontWeight: FontWeight.w600),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          keyboardType: TextInputType.phone,
          onChanged: (String value) {
            _formData['contact'] = value;
          },
          onSaved: (String value) {
            _formData['contact'] = value;
          },
        ));
  }

  Widget _buildPriceTextField(Entry entry) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: getViewportHeight(context) * 0.02,
            horizontal: getViewportWidth(context) * 0.03),
        child: TextFormField(
          style: TextStyle(
              fontSize: getViewportHeight(context) * 0.025,
              fontFamily: "Ubuntu",
              color: Colors.blue),
          decoration: InputDecoration(
              alignLabelWithHint: false,
              prefixIcon: Icon(
                FlutterIcon.rupee,
                color: Colors.red,
                size: getViewportHeight(context) * 0.03,
              ),
              labelText: 'Entry Price',
              labelStyle: TextStyle(
                  fontFamily: "Raleway",
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.red, width: 2),
              )),
          keyboardType: TextInputType.number,
          validator: (String value) {
            if (value.isEmpty ||
                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Price is required and should be number.';
            }
            return null;
          },
          onChanged: (String value) {
            _formData['price'] = double.parse(value);
          },
          onSaved: (String value) {
            _formData['price'] = double.parse(value);
          },
        ));
  }

  Widget _buildOverTextField(Entry entry) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: getViewportHeight(context) * 0.02,
            horizontal: getViewportWidth(context) * 0.03),
        child: TextFormField(
          style: TextStyle(
              fontSize: getViewportHeight(context) * 0.025,
              fontFamily: "Ubuntu",
              color: Colors.blue),
          decoration: InputDecoration(
            alignLabelWithHint: false,
            prefixIcon: Icon(
              FlutterIcon.soccer_ball,
              color: Colors.red,
              size: getViewportHeight(context) * 0.03,
            ),
            labelText: 'Overs Played',
            labelStyle: TextStyle(
                fontFamily: "Raleway",
                color: Colors.black,
                fontWeight: FontWeight.w600),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          keyboardType: TextInputType.number,
          initialValue: entry == null ? '' : entry.price.toString(),
          validator: (String value) {
            if (value.isEmpty ||
                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Over is required and should be number.';
            }
            return null;
          },
          onChanged: (String value) {
            _formData['overs'] = value;
          },
          onSaved: (String value) {
            _formData['overs'] = double.parse(value);
          },
        ));
  }

  void _submitForm(MainModel model) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    model
        .addEntry(
      name: _formData['name'],
      contact: _formData['contact'],
      price: _formData['price'],
      overs: _formData['overs'],
    )
        .then(
      (bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/homepage');
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Something went wrong!'),
                content: Text('Please try again!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }

  Widget _buildSubmitButton(MainModel model) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel) {
        return Container(
            margin: EdgeInsets.only(top: getViewportHeight(context) * 0.05),
            child: model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    splashColor: Colors.white,
                    color: primary,
                    child: Container(
                      width: getViewportWidth(context) * 0.35,
                      height: getViewportHeight(context) * 0.06,
                      alignment: Alignment.center,
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontSize: getViewportHeight(context) * 0.025,
                        ),
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      _submitForm(model);
                    },
                  ));
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Entry entry) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          return SingleChildScrollView(
              child: Container(
            height: getViewportHeight(context),
            margin: EdgeInsets.all(getViewportHeight(context) * 0.01),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildNameTextField(entry),
                  _buildContactTextField(entry),
                  _buildOverTextField(entry),
                  _buildPriceTextField(entry),
                  _buildSubmitButton(model),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Add Entry'),
      ),
      body: _buildPageContent(context, null),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
