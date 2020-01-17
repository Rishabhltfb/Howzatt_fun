import 'package:flutter/cupertino.dart';

class Entry {
  final String id;
  final String name;
  final String contact;
  final double price;
  final double overs;
  final String entryCreator;

  Entry({
    @required this.id,
    @required this.name,
    @required this.contact,
    @required this.price,
    @required this.overs,
    @required this.entryCreator,
  });
}
