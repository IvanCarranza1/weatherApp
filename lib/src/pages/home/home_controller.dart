import 'package:flutter/material.dart';
import 'package:assessment_di/src/utils/progress_dialog.dart' as dialog;
import '../../api/weather_http.dart';
import '../../utils/shared_pref.dart';

class HomeController {
  ///Use to MVC
  late BuildContext context;
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  late SharedPref _sharedPref;

  bool isCityLoaded=false;
  late double temperature;
  late int condition;
  late String cityName;
  late String mainDescription;
  late String description;
  late String minTemp, maxTemp;
  late String termicSensation;
  late DateTime date;
  Color colorBackground = Colors.white;

  //Forecast
  late String hour1, hour2, hour3;
  late String descr1, descr2, descr3;
  late String temp1, temp2, temp3;

  init(BuildContext context, Function refresh) {

    this.context = context;
    this.refresh = refresh;
    _sharedPref = SharedPref();

    getLocationData(true);

    refresh();
  }

  getLocationData(bool byCityName) async {
    dialog.showProgressDialog(context);

    cityName = await getCityDefault();
    if(cityName=='' && byCityName){
      Navigator.pop(context);
      return;
    }

    WeatherModel weatherModel = WeatherModel();
    var weatherData;
    if(byCityName) weatherData = await weatherModel.getCityWeather(cityName);
    else weatherData = await weatherModel.getCityByCoordinates();

    if(weatherData==null){
      Navigator.pop(context);
      return;
    }
    if(!byCityName)cityName = weatherData['name'].toString();
    temperature = double.parse(weatherData['main']['temp'].toString());
    mainDescription = weatherData['weather'][0]["main"].toString();
    description = weatherData['weather'][0]["description"].toString();
    minTemp = weatherData['main']["temp_min"].toString();
    maxTemp = weatherData['main']["temp_max"].toString();
    termicSensation = weatherData['main']["feels_like"].toString();

    if(!byCityName)saveCityDefault(cityName);

    getCurrentDate();
    getForecastData();

  }


  getForecastData() async {
    WeatherModel weatherModel = WeatherModel();
    var forecastData = await weatherModel.getCityForecast(cityName);
    hour1 = getDateForecast(forecastData['list'][0]['dt_txt'].toString());
    hour2 = getDateForecast(forecastData['list'][1]['dt_txt'].toString());
    hour3 = getDateForecast(forecastData['list'][2]['dt_txt'].toString());

    descr1 = forecastData['list'][0]['weather'][0]['main'].toString();
    descr2 = forecastData['list'][1]['weather'][0]['main'].toString();
    descr3 = forecastData['list'][2]['weather'][0]['main'].toString();

    temp1 = forecastData['list'][0]['main']['temp'].toString();
    temp2 = forecastData['list'][1]['main']['temp'].toString();
    temp3 = forecastData['list'][2]['main']['temp'].toString();
    isCityLoaded=true;
    Navigator.pop(context);

    refresh();
  }


  String getCurrentDate(){
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day, now.hour);
    String dateFormat=date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
    setColorHour();
    return dateFormat;
  }

  String getImageWeather(String description){
    if(description=='Clouds')return 'assets/images/nublado.png';
    else if(description=='Thunderstorm')return 'assets/images/trueno.png';
    else if(description=='Drizzle')return 'assets/images/nubes.png';
    else if(description=='Rain')return 'assets/images/lluvioso.png';
    else if(description=='Snow')return 'assets/images/nieve.png';
    else if(description=='Clear')return 'assets/images/sun.png';
    else return 'assets/images/tierra.png';
  }

  void setColorHour(){
    if(date.hour>18) colorBackground = Color(0xFF243B4A);
    else if(date.hour>12) colorBackground = Color(0xFF0E6BA8);
    else colorBackground = Color(0xFF87BCDE);
  }

  Future<String> getCityDefault()async {
    try {
      String cityDefault = await _sharedPref.read('city')??'';
      return cityDefault;
    } catch (error) {
      return '';
    }
  }


  void goToSignUpPage(String city) {
    Navigator.pushNamed(context, 'city', arguments: {
    'city': city,
    });
  }


  void saveCityDefault(String city)async{
    await _sharedPref.save('city', city);
  }

  String getDateForecast(String date){
    String dateDay=date.split(" ")[0];
    String dateHour=date.split(" ")[1].split(":")[0] + 'hrs';
    return dateDay.split("-")[2]+'/'+dateDay.split("-")[1] + ' '+ dateHour;
  }

  void dispose() {
    //TODO: IMPLEMENT DISPOSE TO YOUR LISTENERS
  }

}