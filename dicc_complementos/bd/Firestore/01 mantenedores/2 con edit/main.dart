import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import "frmEditaCliente.dart";


void main() => runApp(MyApp());

List<String> param = [];
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clientes',
      theme: presentacionTheme,
      home: MyHomePage(),
    routes: <String, WidgetBuilder>{
    'frmEditaCliente': (BuildContext context) => FrmEditaCliente(param)}
    );
  }
}


final ThemeData presentacionTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              param.add("INGRESO");
              param.add("");
              Navigator.pushNamed(context, 'frmEditaCliente');

            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('clientes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return FirestoreListView(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index) {
        String nombre = documents[index].data['nombre'].toString();
        String direccion = documents[index].data['direccion'].toString();

        String key = documents[index].documentID;

        return ListTile(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.white),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                    Text(nombre),


                    IconButton(
                    icon: Icon(Icons.update),
                    onPressed: () {
                                param.add("EDITAR");
                                param.add(key);
                                param.add(nombre);
                                param.add(direccion);
                                  print("que onda ${param[2]}");

                                Navigator.pushNamed(context, 'frmEditaCliente');

                    }
                    ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot snapshot =
                        await transaction.get(documents[index].reference);
                        await transaction.delete(snapshot.reference);
                      });
                    },
                  )
                ],
              ),
            ),
            onTap: () => Firestore.instance
                .runTransaction((Transaction transaction) async {
              DocumentSnapshot snapshot =
              await transaction.get(documents[index].reference);

              await transaction.update(
                  snapshot.reference, {"editing": !snapshot["editing"]});
            }));
      },
    );
  }
}
