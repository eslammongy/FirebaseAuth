import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentaion/screens/Verify_phone_number.dart';
import 'package:flutter_maps/presentaion/screens/create_user_account.dart';
import 'package:flutter_maps/presentaion/screens/phone_auth.dart';
import 'package:flutter_maps/presentaion/screens/splash_screen.dart';
import 'package:flutter_maps/presentaion/screens/success_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case spalshScreen:
        return MaterialPageRoute(builder: (_) => SpalshScreen());

      case phoneAuthScreen:
        return MaterialPageRoute(builder: (_) => PhoneAuthScreen());

      case verifyPhoneScreen:
        return MaterialPageRoute(builder: (_) => VerifyPhoneNumber());

      case createAccountScreen:
        return MaterialPageRoute(builder: (_) => CreateUserAccount());

      case wellDoneScreen:
        return MaterialPageRoute(builder: (_) => SuccessScreen());
    }
    return MaterialPageRoute(builder: (_) => SpalshScreen());
  }
}
