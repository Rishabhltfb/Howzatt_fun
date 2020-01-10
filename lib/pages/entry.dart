import 'package:flutter/material.dart';

import '../models/entry.dart';

class EntryPage extends StatefulWidget {
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
    'image': 'assets/user.jpg'
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
          )
        ],
      ),
    );
  }

  Widget _buildNameTextField(Entry entry) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Entry Name'),
      initialValue: entry == null ? '' : entry.name,
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
      initialValue: entry == null ? '' : entry.contact,
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
      initialValue: entry == null ? '' : entry.price.toString(),
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

  // void _submitForm(
  //     Function addEntry, Function updateProduct, Function setSelectedProduct,
  //     [int selectedProductIndex]) {
  //   if (!_formKey.currentState.validate()) {
  //     return;
  //   }
  //   _formKey.currentState.save();
  //   if (selectedProductIndex == -1) {
  //     addProduct(
  //       _formData['title'],
  //       _formData['description'],
  //       _formData['image'],
  //       _formData['price'],
  //     ).then(
  //       (bool success) {
  //         if (success) {
  //           Navigator.pushReplacementNamed(context, '/products')
  //               .then((_) => setSelectedProduct(null));
  //         } else {
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 title: Text('Something went wrong!'),
  //                 content: Text('Please try again!'),
  //                 actions: <Widget>[
  //                   FlatButton(
  //                     onPressed: () => Navigator.of(context).pop(),
  //                     child: Text('Okay'),
  //                   )
  //                 ],
  //               );
  //             },
  //           );
  //         }
  //       },
  //     );
  //   } else {
  //     updateProduct(
  //       _formData['title'],
  //       _formData['description'],
  //       _formData['image'],
  //       _formData['price'],
  //     ).then(
  //       (_) => Navigator.pushReplacementNamed(context, '/products').then(
  //         (_) => setSelectedProduct(null),
  //       ),
  //     );
  //   }
  // }

  Widget _buildSubmitButton() {
    return RaisedButton(
      color: primary,
      child: Text('Save'),
      textColor: Colors.white,
      onPressed: () {},
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
      child: Container(
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
              _buildSubmitButton(),
            ],
          ),
        ),
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
