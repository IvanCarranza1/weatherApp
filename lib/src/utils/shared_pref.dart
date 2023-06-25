import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {

  ///Save the date with his specif key
  ///Receives: String key, String value
  ///Returns: Future<void>
  Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  ///Read the dates with the specif key
  ///Receives: String key
  ///Returns: Future<dynamic>
  Future<dynamic> read(String key) async{
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getString(key) == null) return null;

    return json.decode(prefs.getString(key)!);
  }


  Future<bool> removeAll() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}