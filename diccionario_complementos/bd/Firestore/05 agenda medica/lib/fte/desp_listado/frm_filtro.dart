part of agenda;





class FrmFiltro extends StatefulWidget {
  final ValueSetter<int> seteoFiltro;
  final int filtroActual;
  FrmFiltro({Key key,this.filtroActual,this.seteoFiltro}) : super(key: key);
  @override
  _FrmFiltro createState() => new _FrmFiltro();
}
class _FrmFiltro extends State<FrmFiltro> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  mgraficaMensajeria mje = new mgraficaMensajeria();
  int tVencida;

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
     tVencida=widget.filtroActual;
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title:new Center(child: Text('Filtrado'))
      ),


      body: new SafeArea(
          top: false,
          bottom: false,
          minimum:const EdgeInsets.only(top:80.0,left: 20.0,right:20.0,bottom: 100.0),
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
                padding: const EdgeInsets.only(top: 30.0),
                children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[

                        new  Radio(
                            value: 0,
                            groupValue: tVencida,
                            onChanged: (int data) {
                              {
                                setState(() {
                                  tVencida = data;
                                });
                              }
                            }
                        ),
                        new Text('Pendiente'),
                      ]),//Pendiente
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[

                        new  Radio(
                            value: 1,
                            groupValue: tVencida,
                            onChanged: (int data) {
                              {
                                setState(() {
                                  tVencida = data;
                                });
                              }
                            }
                        ),
                        new Text('Listo'),
                      ]),//Listo
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[

                        new  Radio(
                            value: 2,
                            groupValue: tVencida,
                            onChanged: (int data) {
                              {
                                setState(() {
                                  tVencida = data;
                                });
                              }
                            }
                        ),
                        new Text('Vencida'),
                      ]),//Vencida
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[

                        new  Radio(
                            value: 3,
                            groupValue: tVencida,
                            onChanged: (int data) {
                              {
                                setState(() {
                                  tVencida = data;
                                });
                              }
                            }
                        ),
                        new Text('Todos'),
                      ]),//Todos

                  new Container(

                      padding: const EdgeInsets.only(top: 20.0),
                      child: new RaisedButton(
                          child: const Text('Filtrar'),
                          onPressed: (){
                            if(tVencida==3) tVencida=null;
                            widget.seteoFiltro(tVencida);
                            Navigator.of(context).pop(true);
                          }
                      )),
                ],
              ))),
    ));
  }
}


