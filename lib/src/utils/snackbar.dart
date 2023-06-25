import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar{
  static void showSnackbarCorrect(BuildContext context, GlobalKey<ScaffoldState> key, String text){
    if(key.currentState == null) return;
    FocusScope.of(context).requestFocus(new FocusNode());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.tag_faces,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 1500),
    ));
  }

  static void showSnackbarIncorrect(BuildContext context, GlobalKey<ScaffoldState> key, String text){
    if(key.currentState == null) return;
    FocusScope.of(context).requestFocus(new FocusNode());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.close_outlined,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(milliseconds: 1500),
    ));
  }


  static void showEmptyAnswerSnackBar(BuildContext context, GlobalKey<ScaffoldState> key, String text){
    if(key.currentState == null) return;
    FocusScope.of(context).requestFocus(new FocusNode());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black54,
      duration: Duration(milliseconds: 1500),
    ));
  }
}