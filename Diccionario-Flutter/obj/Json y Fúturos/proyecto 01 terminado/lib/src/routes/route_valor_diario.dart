part of presupuesto;

class _DatoForm{
  DateTime fechaProceso;
  double montoCalcular;

  _DatoForm({this.fechaProceso,this.montoCalcular});

}

class RouteValorDiario extends StatefulWidget {
  RouteValorDiario({Key key}) : super(key: key);
  @override
  State createState() => new _RouteValorDiario();
}

class _RouteValorDiario extends State<RouteValorDiario> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<double> vIF = [0.0,0.0,0.0];
  bool terminoTraida=false;
  String smontoCalculado="1.0";
  _DatoForm _datoForm = new _DatoForm(
                          fechaProceso:DateTime(2018,07,13),
                            montoCalcular:1.0);
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _cMonto = new TextEditingController();

  CFechas _fec =new CFechas(
              fechaInicial:DateTime(2018,07,1),
              fechaFinal:DateTime(2018,07,30),
              fto:Formatos.FechaLatina,
              hinText:"Fecha de Instrumento",
              labelText:"Fecha"
              );

  String primerValorCombo;
  List<String> cambios=["UF->Pesos",
  "Dólar->Pesos",
  "Euro->pesos",
  "Pesos->UF",
  "Pesos->Dólar",
  "Pesos->Euro"];



  Future<bool> _traeInstrumentos(DateTime pdt) async {
    try {
      vIF = await Future.wait([
        valorInstrumentoFinanciero(
            TipoInstrumentoFinanciero.Uf,pdt),
        valorInstrumentoFinanciero(
            TipoInstrumentoFinanciero.Dolar,pdt),
        valorInstrumentoFinanciero(
            TipoInstrumentoFinanciero.Euro,pdt),
      ]);
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  void cargaInstrumentos(){

     print(_datoForm.fechaProceso);
     setState(() {
       vIF[0] = 0.0;
       vIF[1] = 0.0;
       vIF[2] = 0.0;
     });
    _traeInstrumentos(_datoForm.fechaProceso).then((rta) {
      setState(() {
        terminoTraida=rta;
        print(vIF[0]);
      });


    });

  }



  @override
  void initState() {
    super.initState();
    primerValorCombo =cambios[0];
    //smontoCalculado= calculaMontoInstrumento(primerValorCombo);
    cargaInstrumentos();
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      _showMessage('Pantalla no es válida!  Revise y corrija.');
    } else {
      form.save(); //This invokes each onSaved event
       print("Fecha Final ${_datoForm.fechaProceso}");
      print(vIF[0]);
      print(vIF[1]);
      print(vIF[2]);

    }
  }
  String calculaMontoInstrumento(String vCombo){
    double monto=_datoForm.montoCalcular;
    if (monto<=0.0) return formatoDouble(0.0);

    double nMonto;
    switch(vCombo){
      case "UF->Pesos":
        nMonto = vIF[TipoInstrumentoFinanciero.Uf.index-1]*monto;
        break;
      case "Dólar->Pesos":
        nMonto = vIF[TipoInstrumentoFinanciero.Dolar.index-1]*monto;
        break;
      case "Euro->pesos":
        nMonto = vIF[TipoInstrumentoFinanciero.Euro.index-1]*monto;
        break;
      case "Pesos->UF":
        nMonto = monto/vIF[TipoInstrumentoFinanciero.Uf.index-1];
        break;
      case "Pesos->Dólar":
        nMonto = monto/vIF[TipoInstrumentoFinanciero.Dolar.index-1];
        break;
      case "Pesos->Euro":
        nMonto = monto/vIF[TipoInstrumentoFinanciero.Euro.index-1];
        break;
      default:
        nMonto=-1.0;
        break;
    };
    return formatoDouble(nMonto);
  }
  String formatoDouble(double d){

    final formatter = new NumberFormat("###,###.00");
    return formatter.format(d);
  }

  void _showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }


Widget _miForm(bool desliegue) {


  _seteoController(String miFec) {
    setState(() {
        _datoForm.fechaProceso=new  DateTime(_fec.ahora[2],_fec.ahora[1],_fec.ahora[0]);

      _controller.text = miFec;
      cargaInstrumentos();

    });
  }
  void _graboFecha(DateTime dt) {
     _datoForm.fechaProceso = dt;
     cargaInstrumentos();

  }



    Table miTabla(){
    return new Table(
        border: new TableBorder(
            horizontalInside: new BorderSide(color: Colors.grey[200], width: 0.5)
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          new TableRow(
              children: <Widget>[
                new  Text( descripcionTipoInstrumentoFinanciero[TipoInstrumentoFinanciero.Uf.index]),
                new Text(formatoDouble(vIF[TipoInstrumentoFinanciero.Uf.index-1]),
                    textAlign: TextAlign.right),
              ]
          ),
          new TableRow(
              children: <Widget>[
                new  Text( descripcionTipoInstrumentoFinanciero[TipoInstrumentoFinanciero.Dolar.index]),
                new Text(formatoDouble(vIF[TipoInstrumentoFinanciero.Dolar.index-1]),
                    textAlign: TextAlign.right),
              ]
          ),
          new TableRow(
              children:[
                new  Text( descripcionTipoInstrumentoFinanciero[TipoInstrumentoFinanciero.Euro.index]),
                new Text( formatoDouble(vIF[TipoInstrumentoFinanciero.Euro.index-1]),
                    textAlign: TextAlign.right),
              ]
            ),
              ]

          );
}

  void valSeleccionado(String vCombo){
    setState(() {
      primerValorCombo = vCombo;
      smontoCalculado= calculaMontoInstrumento(vCombo);
    });
  }

 if (_controller.text.length == 0)
    _controller.text =
    "${_datoForm.fechaProceso.day}/${_datoForm.fechaProceso.month}/${_datoForm
        .fechaProceso.year}";
  String sMonto="1";
  return new SafeArea (
      top: false,
      bottom: false,
      child: new Form(
          key: _formKey,
          autovalidate: true,
          child: new ListView (
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //_fec.ftoFecha(_controller, _datoForm.fechaProceso, _graboFecha),
                     new Flexible(child:new Text("Día")),
                    _fec.nDia(_datoForm.fechaProceso.day),
                     new Flexible(child:new Text("Mes")),
                    _fec.nMes(_datoForm.fechaProceso.month),
                     new Flexible(child:new Text("Año")),
                    _fec.nAno(_datoForm.fechaProceso.year),
                    _fec.botonFecha(context,_seteoController),
                   _fec.botonCalendario(context, _seteoController),
                ],

              ),

              miTabla(),
              new TextField(
                controller: _cMonto,
                onChanged: (String text) {
                  sMonto = text;
                  _datoForm.montoCalcular = double.parse(text);
                },
              ),
             /*
             new  TextFormField(
                  decoration: const InputDecoration(
                  hintText: 'Monto a calcular',
                  ),
                  initialValue: sMonto,

                  validator: (val) {
                    _datoForm.montoCalcular = double.parse(val);
                    print("valida ${_datoForm.montoCalcular}" );
                    return sMonto.isEmpty ? 'Ingrese monto' : null;
                  },

                 onSaved: (val) {
                   _datoForm.montoCalcular = double.parse(val);
                   print(_datoForm.montoCalcular );
                 }
              ),
              */
              new Combo(
                lCosas:cambios,
                primerValor:primerValorCombo,
                onGetDD:valSeleccionado,
              ),

              new Text(smontoCalculado),




           ],
          )));
}


  @override
  Widget build(BuildContext context) {

    return new Scaffold (
      key:_scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: new Text('Instrumentos'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    body: _miForm(terminoTraida),
    );
}
}


