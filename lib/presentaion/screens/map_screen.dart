import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
    );
  }
}
