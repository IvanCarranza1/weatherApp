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
      backgroundColor: Color(0xFF344966),
      key: _con.key,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: _con.isCityLoaded
                  ? LoadCityInfo()
                  : showNoCityFound(),
            ),
          ),
        ),
      ),
    );
  }

  Widget LoadCityInfo() {
    return Column(
      children: [
        _cityText(),
        _temperatureText(),
        _imageWeather(),
        _descriptionText(),
        _dateText(),
        SizedBox(height: 30),
        _buttonSaveCity()
      ],
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
      _con.temperature.toString() + "°",
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
      _con.mainDescription,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }

  Widget _buttonSaveCity() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
      onPressed: _con.saveCityDefault,
      child: Text('Guardar por defecto', style: TextStyle(
        color: Colors.black87
      ),),
    );
  }

  Widget showNoCityFound() {
    return Column(
      children: [
        _imageEmpty(),
        SizedBox(height: 40,),
        _emptyText()
      ],
    );
  }

  Widget _imageEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Image.asset('assets/images/tierra.png'),
    );
  }

  Widget _emptyText() {
    return Text(
      'No se ha encontrado la ciudad seleccionada',
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: Colors.black54,
      ),
    );
  }
}


