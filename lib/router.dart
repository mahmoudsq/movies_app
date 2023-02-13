import 'core/route_path.dart' as route;
import 'package:flutter/material.dart';

import 'presentation/screens/home/home_screen.dart';

Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case route.homeScreen:
      return PageRouteBuilder(pageBuilder: (_, __, ___) => const HomeScreen());
    default:
      return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('error'),
        ),
        body: const Center(child: Text('error')),
      );
    },
  );
}
