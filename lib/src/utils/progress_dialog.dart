import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


showProgressDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          child:
          Lottie.asset(
            'assets/json/loading.json',
            fit: BoxFit.fill,
          ),
        ),
        Container(margin: EdgeInsets.only(left: 15),child:Text("Espera..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}