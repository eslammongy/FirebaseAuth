import 'package:flutter/cupertino.dart';

class Item {
  Item(this.name, this.icon);
  final String name;
  final Image icon;
}

List<Item> items = <Item>[
  Item(
      '+20',
      Image.asset(
        "assets/images/egypt.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+61',
      Image.asset(
        "assets/images/australia.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+213',
      Image.asset(
        "assets/images/algeria.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+1',
      Image.asset(
        "assets/images/canada.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+1',
      Image.asset(
        "assets/images/usa.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+966',
      Image.asset(
        "assets/images/ksa.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+91',
      Image.asset(
        "assets/images/india.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+39',
      Image.asset(
        "assets/images/italy.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+33',
      Image.asset(
        "assets/images/france.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+965',
      Image.asset(
        "assets/images/kuwait.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+81',
      Image.asset(
        "assets/images/kuwait.png",
        width: 30,
        height: 30,
      )),
  Item(
      '+86',
      Image.asset(
        "assets/images/china.png",
        width: 30,
        height: 30,
      )),
];
