part of presupuesto;

class RouteValorDiario extends StatelessWidget {

  ThemeData miTema= new ThemeData(
    fontFamily: 'Helvetica Neue',
    primarySwatch: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Valor Diario',
      theme:miTema,
      home: new Text("hola a todos"),

    );
  }
}