import 'package:flutter/material.dart';
import 'src/presupuesto_app.dart';
/*
autor : Máximo Meza C
Fecha :13-07-2018

 */
void main() {
  final ThemeData maxSoftTheme = new ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor:Colors.cyanAccent,
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[500],
      primaryColorBrightness: Brightness.light,
      accentColor: Colors.green[500],
      accentColorBrightness: Brightness.light

  );
  final ThemeData unCaso = new ThemeData(
    brightness:  Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor:Colors.blue[500],
    scaffoldBackgroundColor:Colors.tealAccent,
    cardColor:Colors.greenAccent,
    dividerColor:Colors.indigo,
    buttonColor:Colors.blue,
    hintColor:Colors.tealAccent,
    errorColor:Colors.red,
    fontFamily:"Courier",
    /*
      brightness:  Brightness.light,
      primarySwatch:,
      Color primaryColor,
      Brightness primaryColorBrightness,
      Color primaryColorLight,
      Color primaryColorDark,
      Color accentColor,
      Brightness accentColorBrightness,
      Color canvasColor,
      Color scaffoldBackgroundColor,
      Color bottomAppBarColor,
      Color cardColor,
      Color dividerColor,
      Color highlightColor,
      Color splashColor,
      InteractiveInkFeatureFactory splashFactory,
      Color selectedRowColor,
      Color unselectedWidgetColor,
      Color disabledColor,
      Color buttonColor,
      ButtonThemeData buttonTheme,
      Color secondaryHeaderColor,
      Color textSelectionColor,
      Color textSelectionHandleColor,
      Color backgroundColor,
      Color dialogBackgroundColor,
      Color indicatorColor,
      Color hintColor,
      Color errorColor,
      Color toggleableActiveColor,
      String fontFamily,
      TextTheme textTheme,
      TextTheme primaryTextTheme,
      TextTheme accentTextTheme,
      InputDecorationTheme inputDecorationTheme,
      IconThemeData iconTheme,
      IconThemeData primaryIconTheme,
      IconThemeData accentIconTheme,
      SliderThemeData sliderTheme,
      ChipThemeData chipTheme,
      TargetPlatform platform
      */
  );

      runApp(new MaterialApp(
    title: 'Flutter Tutorial',
    theme: maxSoftTheme,
    home: new PresupuestoApp(),
  ));
}
