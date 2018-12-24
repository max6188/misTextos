

library presupuesto;

import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';



part 'util/constantes.dart';
part 'util/mensajes_error.dart';
part 'util/tipo_dato.dart';
part 'util/mgrafica_calendario.dart';
part 'util/mfinanzas_instrumentos.dart';
part 'util/mgrafica_combo_texto.dart';
part 'routes/route_valor_diario.dart';


class PresupuestoApp extends StatelessWidget {


@override
Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      leading: new IconButton(
        tooltip: 'Menú de navegación',
        icon: new Icon(Icons.menu),
        onPressed: null,
      ),
      title: new Text('Principal'),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.mail_outline),
          tooltip: 'Correo',
          onPressed:() {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new RouteValorDiario()),
            );
          },
        ),
      ],
    ),
    // body is the majority of the screen.
    body:  Column(
      children: [RaisedButton(
        child: Text('Launch screen'),
        onPressed:() {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new RouteValorDiario()),
          );
        },
      ),
      ],
    ),
    floatingActionButton: new FloatingActionButton( //el botón flotante
      tooltip: 'Add', // used by assistive technologies
      child: new Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new RouteValorDiario()),
        );
      },
    ),
  );
}
}

