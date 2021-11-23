import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

late String initialRoute;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  var user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () {
        if (user == null) {
          Navigator.pushReplacementNamed(context, welcomeScreen);
        } else {
          Navigator.pushReplacementNamed(context, userProfileScreen);
        }}
      );
  }

  @override
  Widget build(BuildContext context) {
          return  Scaffold(
          backgroundColor: CustomColors.backgroundColor,
          body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
          "assets/images/firebase_logo.png",
          width: 150,
          height: 150,
          ),
          const SizedBox(
          height: 10,
          ),
          Text(
          "Authentication",
          style: TextStyle(
          fontSize: 30,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w800,
          color: CustomColors.colorGrey),
          )
          ],
          )),
          );

  }


}
