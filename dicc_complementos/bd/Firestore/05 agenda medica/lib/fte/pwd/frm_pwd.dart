part of agenda;

///Permite registrarr al usuario
///Solamente Humberto y Maritza

class FrmPwd extends StatefulWidget {
  final ValueSetter<String> registrar;


  FrmPwd({this.registrar,Key key}) : super(key: key);

  @override
  _FrmPwd createState() => new _FrmPwd();
}
class _FrmPwd extends State<FrmPwd> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  mgraficaMensajeria mje = new mgraficaMensajeria();
  DatosUsuario dus = new DatosUsuario("","",1);
  final TextEditingController claveCtrl = new TextEditingController();
  List<String> lNombres=[];
  List<String> lClaves=[];


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

  Future<bool> dbCargaUsuario() async {
    Firestore.instance.collection('Usuarios').getDocuments().then((docSnap) {
      var l = docSnap.documents.toList().toList();
      for (int i = l.length-1;i>=0; i--) {
        lNombres.add(l[i].documentID);
        lClaves.add(l[i].data["clave"]);
        }
      setState(() {
        dus.nombre=lNombres[0];
        //lNombres;
        //lClaves;
      });
      return true;
    });
    return false;
  }

  void initState() {
    super.initState();
    dbCargaUsuario();
    int x=1;

  }


  //aca van los atributos privados
  void _submit() {
    final form = _formKey.currentState;
    if (form.validate() && buenaClave()) {

      form.save();
      _grabar();
    }
  }
  void _grabar() {
    // aca se debiera grabar o realizar el login
    widget.registrar(dus.nombre);
    Navigator.of(context).pop(true);

  }

  bool buenaClave(){
    int index = lNombres.indexWhere((n) => n==dus.nombre);

    if(lClaves[index]!=dus.clave){
      dus.ocurrencias++;
      if(dus.ocurrencias==2) {
        setState(() {
          mje.muestraMensaje(scaffoldKey, "Queda un último intento...");

        });

      }
    if(dus.ocurrencias==3) Navigator.of(context).pop(false);
    return false;

    }

    return true;
  }





  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key:scaffoldKey,
      appBar: new AppBar(
        title: new Center(child: new Text("Igreso de clave")),
      ),


      body: lNombres.length==0?mje.simpleCentrado(context,"Esperando servidor..."):
          new SafeArea(
          top: false,
          bottom: false,
          minimum:const EdgeInsets.only(top:120.0,left: 40.0,right:40.0,bottom: 120.0),

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

                  new Combo(
                    lCosas:lNombres,
                    primerValor:dus.nombre,
                    onGetDD: (String nombre) {
                          setState(() {
                            dus.nombre=nombre;
                          });
                    }
                  ),
                  new TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      //border: const UnderlineInputBorder(),
                      // filled: true,
                      // icon: const Icon(Icons.announcement),
                      hintText: 'Ingrese su clave?',
                      labelText: 'Clave',
                    ),
                    controller: claveCtrl,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    onChanged: (String clave) {

                      dus.clave=clave;

                    },
                  ),
                  new Container(
                      padding: const EdgeInsets.only(top: 45.0),
                      child: new RaisedButton(
                          child: const Text('Ingresar'),
                          onPressed: (){
                            _submit();
                          }
                      )),
                ],
              )))),
    );
  }
}

class DatosUsuario{
  String nombre;
  String clave;
  int ocurrencias;


  DatosUsuario(this.nombre, this.clave, this.ocurrencias);


}