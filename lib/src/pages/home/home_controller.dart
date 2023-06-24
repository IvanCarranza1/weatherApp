import 'package:flutter/material.dart';

import '../../api/weather_http.dart';

class HomeController {
  ///Use to MVC
  late BuildContext context;
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();


  init(BuildContext context, Function refresh) {

    this.context = context;
    this.refresh = refresh;


    refresh();
    //_pushNotificationsProvider.requestPermission();
  }

  getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCityWeather("London");
    print(weatherData.toString());
  }

  void dispose() {
    //TODO: IMPLEMENT DISPOSE TO YOUR LISTENERS
  }
}