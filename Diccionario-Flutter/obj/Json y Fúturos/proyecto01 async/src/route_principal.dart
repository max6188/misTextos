

library presupuesto;

import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



part 'util/constantes.dart';
part 'util/instrumentos_financieros.dart';
part 'routes/route_valor_diario.dart';


class PresupuestoApp extends StatelessWidget {




ThemeData miTema= new ThemeData(
  fontFamily: 'Helvetica Neue',
  primarySwatch: Colors.blueGrey,
);


  @override
  Widget build(BuildContext context) {

    String valorInstrumento ="agora si";
    List<double> list=[];

  Future<String> asyncFunction() async {
      try {
          list = await Future.wait([
          valorInstrumentoFinanciero(TipoInstrumentoFinanciero.Uf, new DateTime.now()),
          valorInstrumentoFinanciero(TipoInstrumentoFinanciero.Dolar, new DateTime.now()),
          valorInstrumentoFinanciero(TipoInstrumentoFinanciero.Euro, new DateTime.now())
          ]);

      } catch (e) {
        print(e.toString());
      }
      return "ok";
    }


      asyncFunction().then((val) {
        print("Los tresvar ${list[0]}  ${list[1]} ${list[2]}");
      });

      print("aca va la gráfica");
    return new MaterialApp(
      title: 'Presupuesto V1.0',
      debugShowCheckedModeBanner: true,
      theme:miTema,
      home: new Text(valorInstrumento),
     routes: <String, WidgetBuilder>{
        '/presupuesto': (BuildContext context) => new RouteValorDiario(),
      },
    );
  }
}