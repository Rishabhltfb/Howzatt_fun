import 'package:flutter/cupertino.dart';

class Entry {
  final String name;
  final String contact;
  final double price;
  final double overs;
  final String image;
  final String userId;

  Entry({
    @required this.name,
    @required this.contact,
    @required this.price,
    @required this.overs,
    @required this.image,
    @required this.userId,
  });
}