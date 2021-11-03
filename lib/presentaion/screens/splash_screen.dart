import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentaion/screens/phone_auth.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key key}) : super(key: key);

  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, phoneAuthScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/location.png",
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "MAPS",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Pacifico",
                  fontWeight: FontWeight.w800,
                  color: AppColor.textColor),
            )
          ],
        )),
      ),
    );
  }
}