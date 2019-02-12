part of agenda;
class mgraficaMensajeria{

  Widget simple(BuildContext context,String glosa){
    return new Text(
      glosa,
      style:DefaultTextStyle.of(context).style.apply(
        fontSizeFactor: 0.5,
        color: Colors.blue,
        decoration: TextDecoration.none,
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.wavy,
      ),
    );
  }

  Widget simpleCentrado(BuildContext context,String glosa){
    return new Center( child:Text(
      glosa,
      style:DefaultTextStyle.of(context).style.apply(
        fontSizeFactor: 0.5,
        color: Colors.blue,
        decoration: TextDecoration.none,
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.wavy,
      ),
    ));
  }

  void muestraMensaje(  GlobalKey<ScaffoldState> scf,String message, [MaterialColor color = Colors.red]) {
    //Pone título en la barra de abajo
    scf.currentState
        .showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}