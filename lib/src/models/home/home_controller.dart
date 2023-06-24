import 'package:flutter/material.dart';

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



  void dispose() {
    //TODO: IMPLEMENT DISPOSE TO YOUR LISTENERS
  }
}