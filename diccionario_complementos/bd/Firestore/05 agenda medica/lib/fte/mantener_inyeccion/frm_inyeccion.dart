part of agenda;

class FrmInyeccion extends StatefulWidget {
  String nombreDB;


  FrmInyeccion(this.nombreDB) ;
  @override
  _FrmInyeccion createState() => new _FrmInyeccion();
}
class _FrmInyeccion extends State<FrmInyeccion> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  TextEditingController fechaHoyCtrl = new TextEditingController();
  TextEditingController numCtrl = new TextEditingController();
  TextEditingController asuntoCtrl = new TextEditingController();
  TextEditingController notaCtrl = new TextEditingController();




  final String  proximaInyeccion="90";

  InyeccionFrm dIFrm = new InyeccionFrm();

  Future<bool> willPop() async {
    final FormState form = _formKey.currentState;
    if (form == null || form.validate())
      return true;
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text('Hay errores'),
          content: const Text('Realmente te vas?'),
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

  void initState() {
    super.initState();
    dIFrm.desdeCuando=DateTime.now();
    dIFrm.numdias=int.parse(proximaInyeccion);
    dIFrm.asunto="Inyección";
    dIFrm.nota="";

    numCtrl.text=proximaInyeccion;
    asuntoCtrl.text=dIFrm.asunto;
    notaCtrl.text="";
  }

  //aca van los atributos privados
  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      dIFrm.cuando = dIFrm.desdeCuando.add(new Duration(days: dIFrm.numdias));
      _grabar();
    }
  }
  void _grabar() {
    dbInsertaInyeccion(dIFrm,widget.nombreDB);
    Navigator.of(context).pop(true);

  }
  @override
  Widget build(BuildContext context) {
    fechaHoyCtrl.text = formateoFechaL(dIFrm.desdeCuando);
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(child: Text('Próxima Inyeccion')),
      ),


      body: new SafeArea(
          top: false,
          bottom: false,
          minimum:const EdgeInsets.only(top:50.0,left: 20.0,right:20.0,bottom:55.0),
          child: new Container(
              decoration: new BoxDecoration(
                border: new Border.all(width: 10.0, color: Colors.black38),
                borderRadius:const BorderRadius.all(const Radius.circular(8.0)),
              ),
            child: new Form(
              key: _formKey,
              autovalidate: true,
              onWillPop: willPop,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new FechaCalendario(
                    context: context,
                    fechaOk: (DateTime dtFec) {
                      fechaHoyCtrl.text = formateoFechaL(dtFec);
                      dIFrm.desdeCuando = dtFec;
                    },
                    fechaDesde: new DateTime(2018, 08, 11),
                    fechaHasta: new DateTime(2025, 12, 31),
                    ctrlFecha: fechaHoyCtrl,
                    hinText: "Fecha",
                    labelText: "Última inyección:",

                  ),
                  new VEntero(
                      hinText:"Número",
                      numCtrl:numCtrl,
                      labelText:"Próxima Inyección",
                      lInferior:0,
                      lSuperior: 150,
                      numeroDevuelto:(int rta){
                        numCtrl.text=rta.toString();
                      }
                  ),
                  new TextField(
                    decoration: const InputDecoration(
                      //border: const UnderlineInputBorder(),
                      // filled: true,
                      // icon: const Icon(Icons.announcement),
                      hintText: 'Cual es el asunto?',
                      labelText: 'Asunto',
                    ),
                    controller: asuntoCtrl,
                    keyboardType: TextInputType.text,
                    onChanged: (String texto) {
                      dIFrm.asunto = texto;
                    },
                  ),//asunto
                  new TextField(
                    decoration: const InputDecoration(
                      //border: const UnderlineInputBorder(),
                      // filled: true,
                      // icon: const Icon(Icons.announcement),
                      hintText: 'Ingrese una nota?',
                      labelText: 'Nota',
                    ),
                    controller: notaCtrl,

                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    onChanged: (String texto) {
                      dIFrm.nota = texto;
                    },
                  ),//Nota
                  new Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new RaisedButton(
                          child: const Text('Generar'),
                          onPressed: (){
                            _submit();
                          }
                      )),
                ],
              ))),
    ));
  }
}

class InyeccionFrm{
  DateTime desdeCuando;
  int numdias;
  String asunto;
  String nota;
  DateTime cuando;
}