import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';



import 'package:cloud_firestore/cloud_firestore.dart';


class Cliente{
  String fbKey;
  String nombre;
  String direccion;
}

class FrmEditaCliente extends StatefulWidget {
  List<String> arg = [];


  FrmEditaCliente(this.arg);

  @override
  _LoginPageState createState() => new _LoginPageState(arg);
}

class _LoginPageState extends State<FrmEditaCliente> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  List<String> arg = [];
  Cliente cliente = new Cliente();


  bool saved = false;


  _LoginPageState(this.arg);


  void cargaDatos(){
    switch(arg[0]){
      case "INGRESO":
        cliente.fbKey="";
        cliente.nombre="";
        cliente.direccion="";
        break;
      case "EDITAR":
        cliente.fbKey=arg[1];
        cliente.nombre=arg[2];
        cliente.direccion=arg[3];
        break;
      default:
        break;
    }
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      _performLogin();
    }
  }



  void _performLogin() {
   // aca se debiera grabar o realizar el login
    saved = true;
  switch(arg[0]){
    case "INGRESO":
        insertaRegistro();
      break;
    case "EDITAR":
      print("ingresa al editar");
      modificaRegistro();


      break;
    default:
      break;
  }

  }


  void modificaRegistro(){
    print("aca vamos");
    Firestore.instance
        .collection("clientes")
        .document(cliente.fbKey)
        .setData({'nombre': cliente.nombre,
               'direccion':cliente.direccion});

    Firestore.instance.collection('channels').document(cliente.fbKey).get().then((doc) {
      print("encontro ${cliente.fbKey}");
    });

  }
  void insertaRegistro(){
    Firestore.instance
        .runTransaction((Transaction transaction) async {
      CollectionReference reference =
      Firestore.instance.collection('clientes');

      await reference.add({"nombre": cliente.nombre,"direccion": cliente.direccion});
    });
  }

  Future<bool> willPop() async {
      return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text('Formulario incompleto'),
          content: const Text('Realmente desea salir?'),
          actions: <Widget> [
            new FlatButton(
              child: const Text('SI'),
              onPressed: () { Navigator.of(context).pop(true); },
            ),
            new FlatButton(
              child: const Text('NO'),
              onPressed: () { Navigator.of(context).pop(false); },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    cargaDatos();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edita Clientes"),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: formKey,
              autovalidate: true,
              onWillPop: willPop,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                children: <Widget>[

                  //Nombre de usuario
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Entre nombre de Cliente',
                      labelText: 'Cliente',
                    ),
                    initialValue: cliente.nombre,
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'Nombre es Requerido' : null,
                    onSaved: (val) =>  cliente.nombre = val,
                  ),

                  // direccion
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Ingrese dirección sin comuna',
                      labelText: 'Dirección',
                    ),
                    initialValue: cliente.direccion,
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    onSaved: (val) =>  cliente.direccion = val,
                  ),



                  new RaisedButton(
                    onPressed: _submit,
                    child: new Text('Agregar'),
                  ),

                ],
              ))),
    );
  }

}

