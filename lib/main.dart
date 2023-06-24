import 'package:assessment_di/src/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      navigatorKey: navigatorKey,
      home: const Home(),
      theme: ThemeData(
        fontFamily: 'proxima',
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
      ),
      getPages: [
        GetPage(name: '/splash', page: () => const Home()),

      ],
    );
  }
}