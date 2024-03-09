import 'package:flutter/cupertino.dart';
import 'package:flutter_terminchi/models/data_model.dart';
import 'package:flutter_terminchi/screens/about_screen.dart';
import 'package:flutter_terminchi/screens/home_screen.dart';
import 'package:flutter_terminchi/screens/termin_subscreen.dart';

abstract class RouteName {
  static const String home = '/';
  static const String about = '/about';
  static const String details = '/details';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments as DataModel?;
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/about':
        return CupertinoPageRoute(
          builder: (_) => const AboutScreen(),
        );
      case '/details':
        return CupertinoPageRoute(
          builder: (_) =>  TerminSubScreen(data : args as DataModel),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }


  }
}
