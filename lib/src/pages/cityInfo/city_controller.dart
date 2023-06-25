import 'package:assessment_di/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:assessment_di/src/utils/progress_dialog.dart' as dialog;
import '../../api/weather_http.dart';
import 'package:assessment_di/src/utils/snackbar.dart' as snackbar;


class CityController {
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

  late SharedPref _sharedPref;

  init(BuildContext context, Function refresh) {

    this.context = context;
    this.refresh = refresh;
    _sharedPref = SharedPref();

    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    cityName = arguments['city'].toString();

    getLocationData();

    refresh();
  }

  getLocationData() async {
    dialog.showProgressDialog(context);
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCityWeather(cityName);
    if(weatherData==null){
      Navigator.pop(context);
      return;
    }
    temperature = double.parse(weatherData['main']['temp'].toString());
    mainDescription = weatherData['weather'][0]["main"].toString();
    description = weatherData['weather'][0]["description"].toString();
    Navigator.pop(context);

    print("asdasd" + mainDescription);
    getCurrentDate();
    isCityLoaded=true;

    refresh();
  }


  String getCurrentDate(){
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day, now.hour);
    String dateFormat=date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
    return dateFormat;
  }

  void saveCityDefault()async{
    await _sharedPref.save('city', cityName);
    snackbar.Snackbar.showSnackbarCorrect(context, key, "Guardada por defecto");
  }

  String getImageWeather(){
    if(mainDescription=='Clouds')return 'assets/images/nublado.png';
    else if(mainDescription=='Thunderstorm')return 'assets/images/trueno.png';
    else if(mainDescription=='Drizzle')return 'assets/images/nubes.png';
    else if(mainDescription=='Rain')return 'assets/images/lluvioso.png';
    else if(mainDescription=='Snow')return 'assets/images/nieve.png';
    else if(mainDescription=='Clear')return 'assets/images/sun.png';
    else return 'assets/images/tierra.png';
  }



  void dispose() {
    //TODO: IMPLEMENT DISPOSE TO YOUR LISTENERS
  }
}