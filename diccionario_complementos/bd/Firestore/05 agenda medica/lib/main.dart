


import 'package:flutter/material.dart';

import"fte/agenda_app.dart";


final ThemeData maxSoftTheme = new ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlue[800],
  accentColor: Colors.cyan[600],
  textTheme: new TextTheme(
    body1: new TextStyle(color: Colors.blue,fontSize: 15.0,
                        fontWeight: FontWeight.bold),
    subhead:new TextStyle(color:Colors.green),

  ),
  dialogBackgroundColor:Colors.red,
);

void main() {
   runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Agenda médica',
    theme:maxSoftTheme,
    home: new AgendaApp(),
  ));
}

