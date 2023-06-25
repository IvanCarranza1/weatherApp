import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assessment_di/src/models/location.dart';

/// step 2. class that Fetch data from API using url
/// weather API network helper
/// pass the weatherAPI url
///  to this class to get geographical coordinates
class NetworkData {
  NetworkData(this.url);
  final String url;


  /// get geographical coordinates from open weather API call
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

/// step 3. call the class that fetches response from API and pass URL
/// we can get data by location coordinates or city name
/// N.B there are many other ways of getting weather data through the url
const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';
const forecastApiUrl = 'http://api.openweathermap.org/data/2.5/forecast';

class WeatherApi {
  String apiKey = 'bd85f8c4f0366a9fd5787e20e7fe5c39';
  late int status;

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$weatherApiUrl?q=$cityName&appid=$apiKey&units=metric&lang=es';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityByCoordinates() async {
    Location location = Location();
    await location.getCurrentLocation();

    var url = '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitide}&appid=$apiKey&units=metric&lang=es';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityForecast(String cityName) async {
    var url = '$forecastApiUrl?q=$cityName&appid=$apiKey&lang=es&units=Metric';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }
}
