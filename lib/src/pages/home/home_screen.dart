import 'package:assessment_di/src/models/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import '../../api/weather_http.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<Home> with TickerProviderStateMixin {
  final HomeController _con = HomeController();
  var isLoades = false;

  Widget customSearchBar = const Text('Inicio');

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    _con.getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      key: _con.key,
      appBar: AppBar(
        backgroundColor: const Color(0xFF375C8E),
        title: Text("App de Clima"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
