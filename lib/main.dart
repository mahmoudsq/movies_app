import 'package:flutter/material.dart';
import 'package:movies_app/core/route_path.dart';
import '../router.dart' as route;

import 'data/local_service/local_database_helper.dart';
import 'data/navigation_service/navigation_service.dart';
import 'data/web_service/request_helper.dart';

Future<void> dbInstallation()async{
  DBHelper helper= DBHelper();
  //await helper.deleteDatabase();
  await helper.createDataBase();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await dbInstallation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MOmar Movie Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: route.controller,
      initialRoute: homeScreen,
    );
  }
}

