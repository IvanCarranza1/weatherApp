import 'package:flutter/material.dart';

import '../../api/weather_http.dart';

class HomeController {
  ///Use to MVC
  late BuildContext context;
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  bool isCityLoaded=false;
  late double temperature;
  late int condition;
  late String cityName;
  late String mainDescription;
  late String description;
  late String weatherIcon;
  late String tempIcon;
  late DateTime date;
  Color colorBackground = Colors.white;


  init(BuildContext context, Function refresh) {

    this.context = context;
    this.refresh = refresh;

    refresh();
  }

  getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCityWeather("Ontario");
    print(weatherData.toString());

    cityName = weatherData['name'].toString();
    temperature = double.parse(weatherData['main']['temp'].toString());
    mainDescription = weatherData['weather'][0]["main"].toString();
    description = weatherData['weather'][0]["description"].toString();

    getCurrentDate();

    isCityLoaded=true;
    refresh();
  }


  String getCurrentDate(){
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day, now.hour);
    String dateFormat=date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
    setColorHour();
    return dateFormat;
  }

  String getImageWeather(){
    if(mainDescription=='Clouds')return 'assets/images/nubes.png';
    else if(mainDescription=='Clear')return 'assets/images/sun.png';
    else return 'assets/images/test.png';
  }

  void setColorHour(){
    if(date.hour>18) colorBackground = Color(0xFF243B4A);
    else if(date.hour>12) colorBackground = Color(0xFF0E6BA8);
    else colorBackground = Color(0xFF87BCDE);
  }

  void goToSignUpPage(String city) {
    Navigator.pushNamed(context, 'city', arguments: {
    'city': city,
    });
  }

  void dispose() {
    //TODO: IMPLEMENT DISPOSE TO YOUR LISTENERS
  }
}