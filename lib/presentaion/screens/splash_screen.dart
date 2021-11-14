import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/constants/colors.dart';

late String initialRoute;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, phoneAuthScreen);
        } else {
          Navigator.pushReplacementNamed(context, googleMapsScreen);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/location.png",
            width: 150,
            height: 150,
          ),
          const SizedBox(
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
    );
  }
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
