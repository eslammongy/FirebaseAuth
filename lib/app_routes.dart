import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentaion/screens/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SpalshRoute:
        return MaterialPageRoute(builder: (_) => SpalshScreen());
    }
    return MaterialPageRoute(builder: (_) => SpalshScreen());
  }
}
