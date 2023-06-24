import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'city_controller.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<City> with TickerProviderStateMixin {
  final CityController _con = CityController();
  var isLoades = false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: _con.colorBackground,
      key: _con.key,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            color: _con.colorBackground,
            child: _con.isCityLoaded?Column(
              children: [
                _cityText(),
                _temperatureText(),
                _imageWeather(),
                _descriptionText(),
                _dateText(),
              ],
            ):SizedBox(height: 20,),
          ),
        ),
      ),
    );
  }

  Widget _imageWeather() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Image.asset(_con.getImageWeather()),
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _cityText() {
    return Text(
      _con.cityName,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 25,
        color: Colors.white,
      ),
    );
  }

  Widget _temperatureText() {
    return Text(
      _con.temperature.toString()+"°",
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 45,
        color: Colors.white,
      ),
    );
  }

  Widget _descriptionText() {
    return Text(
      _con.description,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 25,
        color: Colors.white,
      ),
    );
  }

  Widget _dateText() {
    return Text(
      _con.getCurrentDate(),
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}
