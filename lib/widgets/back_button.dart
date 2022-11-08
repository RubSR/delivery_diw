import 'package:flutter/material.dart';

Widget backButton(Color color, BuildContext context){
  return FloatingActionButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back, color: color, size: 28.0),
    backgroundColor: Color.fromRGBO(7, 7, 7, 0.30196078431372547),
  );
}