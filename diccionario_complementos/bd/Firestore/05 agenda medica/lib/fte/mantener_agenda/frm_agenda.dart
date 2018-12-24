part of agenda;
///
/// Autor Máximo Meza C
/// fecha 20180809
///Objetivo: Formulario de ingreso de citas
///
///
class FrmAgenda extends StatefulWidget {
  final String dBkey;
  final String nombreDB;
  FrmAgenda({this.dBkey,this.nombreDB}); //FrmAgenda({Key key,String DBkey}) : super(key: key);


  @override
  _FrmAgenda createState() => new _FrmAgenda();
}

class _FrmAgenda extends State<FrmAgenda> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  TextEditingController fechaCtrl = new TextEditingController();
  SoporteFrmAgenda sop = new SoporteFrmAgenda();
  DatosAgenda dFrm = new DatosAgenda();
  mgraficaMensajeria mje = new mgraficaMensajeria();
  final TextEditingController asuntoCtrl = new TextEditingController();
  final TextEditingController notaCtrl = new TextEditingController();
  bool lecturacompleta=false;



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
          actions: <Widget>[
            new FlatButton(
              child: const Text('SI'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  Future<DatosAgenda> cargaCita() async {
    Firestore.instance.collection(widget.nombreDB).document(widget.dBkey).get().then((docSnap) {
      setState(() {

        dFrm.lectura(docSnap.data);
        lecturacompleta=true;
       return dFrm;
      });
    });
    return null;
    }
  void initState() {
    super.initState();
    dFrm.inicio(sop);
    if(widget.dBkey.isNotEmpty){
      cargaCita().then((rta) {
        setState(() {
            if(rta!=null)dFrm=rta;
        });

      });

    } else lecturacompleta=true;
  }




  //aca van los atributos privados

  void _submit() {
    final form = _formKey.currentState;
    if(asuntoCtrl.text=="") {
      mje.muestraMensaje( scaffoldKey, "Debe ingresar asunto...");
      return;
    }
    if (form.validate()) {
      form.save();

      _grabar();
    }
  }

  void _grabar() {

    if(widget.dBkey.isEmpty) dbInsertaRegistro(dFrm,widget.nombreDB) ;
    else dbModificaAgenda(dFrm,widget.nombreDB,widget.dBkey);
    Navigator.of(context).pop(true);
    }

  Table miTabla() {
      return new Table(
        /*
        border: new TableBorder(
            horizontalInside: new BorderSide(color: Colors.grey[200], width: 0.5)
        ),
        */
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            new TableRow(
                children: <Widget>[
                  new Text("Donde:"),
                  new Combo(
                    lCosas: sop.doyDonde(),
                      primerValor: dFrm.donde,
                      onGetDD: (String value) {
                      setState(() {
                        dFrm.donde = value;
                      });
                    },
                  ), //Donde
                ]
            ), //donde
            new TableRow(
                children: <Widget>[
                  new Text("Que:"),
                  new Combo(
                    lCosas: sop.doyQue(),
                    primerValor: dFrm.que,
                    onGetDD: (String value) {
                      setState(() {
                        dFrm.que = value;
                      });
                    },
                  ),
                ] //que

            ),//que
            new TableRow(
                children: [
                  new Text("Quién:"),
                  new Combo(
                    lCosas: sop.doyQuien(),
                    primerValor: dFrm.quien,
                    onGetDD: (String value) {
                      setState(() {
                        dFrm.quien = value;
                      });
                    },
                  ), //quien
                ]
            ), //quien
          ]
      );
    }

  Row radio() {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Radio(
              value: 0,
              groupValue: dFrm.vencida,
              onChanged: (int data) {
                setState(() {
                  dFrm.vencida = data;
                });
              }
          ),
          new Text('Pendiente'),
          new Radio(
              value: 1,
              groupValue: dFrm.vencida,
              onChanged: (int data) {
                setState(() {
                  dFrm.vencida = data;
                });
              }
          ),
          new Text('Listo'),
          new Radio(
              value: 2,
              groupValue: dFrm.vencida,
              onChanged: (int data) {
                setState(() {
                  dFrm.vencida = data;
                });
              }
          ),
          new Text('Vencida'),
        ],
      );
    }



    @override
    Widget build(BuildContext context) {

      asuntoCtrl.text=dFrm.asunto;
      notaCtrl.text=dFrm.nota;
      fechaCtrl.text = formateoFechaL(dFrm.cuando);
      return new Scaffold(
        key:scaffoldKey,
        appBar: new AppBar(
          title: new Center(child: Text('Editar'))
        ),
        body: !lecturacompleta?mje.simpleCentrado(context, "Esperando servidor..."):
        new SafeArea(
            top: false,
            bottom: false,
            minimum:const EdgeInsets.only(top:10.0,left: 10.0,right:10.0,bottom: 10.0),
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border.all(width: 10.0, color: Colors.black38),
                borderRadius:const BorderRadius.all(const Radius.circular(8.0)),
              ),
              child:new Form(
                key: _formKey,
                autovalidate: true,
                onWillPop: willPop,
                child: new ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    new FechaCalendario(
                      context: context,
                      fechaOk: (DateTime dtFec) {
                        fechaCtrl.text = formateoFechaL(dtFec);
                        dFrm.cuando = dtFec;
                      },
                      fechaDesde: new DateTime(2018, 08, 01),
                      fechaHasta: new DateTime(2030, 12, 31),
                      ctrlFecha: fechaCtrl,
                      hinText: "Fecha",
                      labelText: "F.de.compromiso:",

                    ),

                    miTabla(),
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
                        dFrm.asunto = texto;
                      },
                    ),
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
                        dFrm.nota = texto;
                      },
                    ),
                    radio(),
                    new Container(
                        padding:const EdgeInsets.only(top:25.0),
                       child: new RaisedButton(
                            child: const Text('Grabar'),
                            onPressed: () {
                              _submit();
                            }
                        )),
                  ],
                )),
      )));
    }
  }

