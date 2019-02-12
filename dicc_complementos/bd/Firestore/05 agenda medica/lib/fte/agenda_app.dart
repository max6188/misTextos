library agenda;
///
///autor:Máximo Meza
///correo; max82574971@gmail.com
///github: max6188
///Función:Clase auxiliar para manejar el formulario;
///


import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:validator/validator.dart' as val;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_launcher_icons/android.dart';






part "maxlib/mgrafica_comboV2.dart";
part "maxlib/mgrafica_fecha_calendarioV4.dart";
part "maxlib/mgrafica_formatosV1.dart";
part "maxlib/mgrafica_vEnteroV2.dart";
part "maxlib/mgrafica_mensajeriaV1.dart";
part  "mantener_agenda/frm_agenda.dart";
part  "mantener_agenda/soporte_frm_agenda.dart";
part  "mantener_agenda/db_frm_agenda.dart";
part "mantener_agenda/datos_agenda.dart";
part "mantener_agenda/IcMediicos.dart";
part  "mantener_inyeccion/frm_inyeccion.dart";
part "pwd/frm_pwd.dart";
part "pwd/db_usuarios.dart";
part "desp_listado/frm_listado.dart";
part "desp_listado/frm_filtro.dart";


class AgendaApp extends StatefulWidget {

  AgendaApp({Key key}) : super(key: key);
  @override
  _AgendaApp createState() => new _AgendaApp();
}
class _AgendaApp extends State<AgendaApp> {
  /////////////////////////////////
  String nombreDB="";
  bool permiteUsuario=false;
  ////////////////////////////////
  mgraficaMensajeria mje=mgraficaMensajeria();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  int tVencida;

  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();



    }

   return new Scaffold(
      key:scaffoldKey,
      appBar: new AppBar(
      title: new Center(child: Text('Agenda Médica')), //el título
        actions: <Widget>[
          new IconButton(
            icon: new Icon(IcMediicos.inyeccion),
            tooltip: 'Inyección',
            onPressed: (){
              if(permiteUsuario) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new FrmInyeccion(nombreDB)),

                );
              }else{
                mje.muestraMensaje( scaffoldKey, "Debe registrarse...");
              }
            },
          ),
          new IconButton(
            icon: new Icon(Icons.verified_user),
            tooltip: 'Registro',
            onPressed: (){
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new FrmPwd(registrar:(usr){
                                                                       nombreDB="F$usr";
                                                                       permiteUsuario=true;

                })),

              );
            },
          ),
          new IconButton(
            icon: new Icon(Icons.find_in_page),
            tooltip: 'Filtrar',
            onPressed: (() {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new FrmFiltro( filtroActual:tVencida,
                    seteoFiltro:(elSeteo){
                       tVencida=elSeteo;

                }

                )),

              );
            }),
          )
        ],
      ),

      body: permiteUsuario?frmListado(nombreDB): mje.simpleCentrado(context, "Registrese por favor.."),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Agregar',
        child: new Icon(Icons.add),
        onPressed:(){
          if(permiteUsuario) {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new FrmAgenda(
                  dBkey: "", nombreDB: nombreDB)),

            );
          } else {
            mje.muestraMensaje( scaffoldKey, "Debe registrarse...");
          }
        },
      ),
    );
  }

  Widget frmListado(String nombreDB) {
    return new Container(
        decoration: new BoxDecoration(
          border: new Border.all(width: 10.0, color: Colors.black38),
          borderRadius:const BorderRadius.all(const Radius.circular(8.0)),

        ),
        margin:const EdgeInsets.only(top:10.0,bottom:10.0),
         child:new StreamBuilder(
      stream: Firestore.instance.collection(nombreDB).orderBy("cuando").where("vencida",isEqualTo:tVencida).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return FirestoreListView(documents: snapshot.data.documents,nombreDB: nombreDB);
      },
    ));

  }

}
