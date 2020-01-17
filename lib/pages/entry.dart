import 'package:flutter/material.dart';
import 'package:howzatt_fun/widgets/admin.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../models/entry.dart';
import '../widgets/logout.dart';

class EntryPage extends StatefulWidget {
  final MainModel model;
  EntryPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _EntryPageState();
  }
}

class _EntryPageState extends State<EntryPage> {
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
    return TextFormField(
      decoration: InputDecoration(labelText: 'Entry Name'),
      validator: (String value) {
        if (value.isEmpty || value.length < 3) {
          return 'Name is required and should be 3+ character long.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildContactTextField(Entry entry) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contact Number'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty || value.length != 10) {
          return 'Description is required and should be 10 character long.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['contact'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Entry entry) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Entry Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be number.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildOverTextField(Entry entry) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Over Played'),
      keyboardType: TextInputType.number,
      initialValue: entry == null ? '' : entry.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be number.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['overs'] = double.parse(value);
      },
    );
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
                    child: Text('Okay'),
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
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RaisedButton(
                elevation: 20,
                color: primary,
                child: Text('Save'),
                textColor: Colors.white,
                onPressed: () {
                  _submitForm(model);
                },
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Entry entry) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                children: <Widget>[
                  _buildNameTextField(entry),
                  _buildContactTextField(entry),
                  _buildOverTextField(entry),
                  _buildPriceTextField(entry),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildSubmitButton(model),
                ],
              ),
            ),
          );
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
}
