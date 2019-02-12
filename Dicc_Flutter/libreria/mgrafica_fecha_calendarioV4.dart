part of agenda;
/*
autor:Máximo Meza
correo; max82574971@gmail.com
github: max6188
Función:Obtencion de fecha;
la Clase FechaCalendario proporciona la forma de ingresar una fecha en castellano tanto por
texto como por un calendario

explicacion abajo
*/

enum _ValFecha{
  IsOk,
  EsperandoFecha,
  DiaMayor31,
  MesMayor12,
  FechaMenor,
  FechaMayor,
  FechaRara,
}
List<String> _mjeError=[
  "",
  "Fecha Incompleta",
  "Día mayor de 31",
  "Mes mayor que 12",
  "Fecha menor del rango solicitado",
  "Fecha mayor del rango solicitado",
  "Fecha tiene caracteres extraños",
];

//https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/date_and_time_picker_demo.dart

class FechaCalendario extends StatelessWidget {
   DateTime fechaSeleccionada;                    // Valor seleccionado por el calendario
  final ValueSetter<DateTime> fechaOk;          //Función que devuelve valor cambiado
  final BuildContext context;                          //Contexto
  final DateTime fechaDesde;                     //Fecha desde
  final DateTime fechaHasta;                     //Fecha hasta
  final String   hinText;                        //Indicacion del texto
  final String   labelText;                      //Label de la fecha
  final TextEditingController ctrlFecha;        //Controlador de la fech
  //////////////////
   /////
  //final TextEditingController _controller = new TextEditingController();


  FechaCalendario({this.fechaOk, this.context,
      this.fechaDesde, this.fechaHasta, this.hinText,
      this.labelText,this.ctrlFecha}):
        assert(context!=null),
        assert(fechaDesde!=null),
        assert(fechaHasta!=null),
        assert(ctrlFecha!=null),
        assert(fechaDesde.isBefore(fechaHasta));



  //Calendario
  Future _escogeFecha(BuildContext context,DateTime fechaInicial,grabo(DateTime tFex)) async {
    var fec = await showDatePicker(
        context: context,
        initialDate: fechaInicial,
        firstDate: fechaDesde,
        lastDate: fechaHasta);

    if (fec == null) return;
    fechaSeleccionada=fec;

    fechaOk(fec);
  }


  Widget botonCalendario(BuildContext context) {
    return new IconButton(
      icon: new Image.asset('iconos/calendario.png'),
      tooltip: 'Escoger Fecha',
      onPressed: (() {
        DateTime f = new DateFormat.yMd().parseStrict(_cambioFormato(ctrlFecha.text));

        _escogeFecha(context,f,fechaOk);
      }),
    );
  }

  Widget botonCalcular() {
    return new IconButton(
      icon:   new Icon(Icons.account_balance),
      tooltip: 'Calcular',
      onPressed: (() {
        DateTime f;
        String mifec=ctrlFecha.text;
        String sFecha=_cambioFormato(ctrlFecha.text);
        if(esFechaLatina(mifec)){
           f = new DateFormat.yMd().parseStrict(sFecha);
          fechaSeleccionada = f;
          fechaOk(f);
        } else {
          fechaOk(f);

        }

      }),
    );
  }
  //Formato fecha en cadena

  TextFormField fechaTexto(){
////////////////////////////////////////////////////////////////////////////////



      return  new TextFormField(
          decoration: new InputDecoration(
             hintText: this.hinText,
             labelText: this.labelText,
           ),
           controller: ctrlFecha,
           keyboardType: TextInputType.datetime,
           inputFormatters: [new _FormatoIngresoFecha()],

           validator: (val) {
             _ValFecha rta =_esValidaFechaLatina(val,fechaDesde,fechaHasta);
              return rta==_ValFecha.IsOk
              ? null
              : _mjeError[rta.index];

             },
             onSaved:(val) {
                String sFec=_cambioFormato(val);
                DateTime f = new DateFormat.yMd().parseStrict(sFec);
                fechaOk(f);
             }



  );
}

  //principal
  @override
  Widget build(BuildContext context) {
    //TextFormField fecha;

    return new Container(
     child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children:[
         new Flexible( child:fechaTexto()),
          //new Flexible(child:botonCalcular()),
         new Flexible(child:botonCalendario(context)),
       ]
    )
    );
  }
}


class _FormatoIngresoFecha extends TextInputFormatter {
  // //https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/text_form_field_demo.dart
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {

    //final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    final StringBuffer newText = new StringBuffer();
   var re = new RegExp('[a-zA-Z]');
    if(re.hasMatch(newValue.text)){
      newText.write(oldValue.text);
      selectionIndex--;
    } else  newText.write(newValue.text);

    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
} //Formato de la fecha

//Subtutinas desacopladas

String _cambioFormato(String miFec){
  List <int> l = _trozeaFecha (miFec);
  String nuevoFto="${l[1]}/${l[0]}/${l[2]}";
  return  nuevoFto;

}  //String en formato usa

List <int> _trozeaFecha(String miFec){
  String miFec2=miFec.length>10?miFec.substring(0,10):miFec;
  List <String> lF= miFec2.split("/");
  List<int> num=[];
  for(String s in lF) {
    if(s.length!=0 && val.isNumeric(s)){
      List <String> lB=s.split("\\");
      num.add(int.parse(lB[0]));
    }
  }
  return num;
}  //da un arreglo de enteros con la fecha parseada

_ValFecha validaExpresionFechaLatina(String fechaDigitada) {
        List <int> l = _trozeaFecha (fechaDigitada);
        int nDia=l.length>=1?l[0]:0;
        int nMes=l.length>=2?l[1]:0;


        switch(l.length){
          case 1:
            if(nDia>31) return _ValFecha.DiaMayor31;
            return _ValFecha.EsperandoFecha;
          case 2:
            if(nMes>12) return _ValFecha.MesMayor12;
            return _ValFecha.EsperandoFecha;
          case 3:
            try
            {
              String fechaAux=_cambioFormato(fechaDigitada);
              DateTime d =new DateFormat.yMd().parseStrict(fechaAux);
            } catch (e) {
              return _ValFecha.FechaRara;
            }
            return _ValFecha.IsOk;
          default:
            return _ValFecha.FechaRara;

        }
} //validacion de digitacion

bool esFechaLatina(String fechaLatina){
  try
  {
    String fechaAux=_cambioFormato(fechaLatina);
    DateTime d =new DateFormat.yMd().parseStrict(fechaAux);
  } catch (e) {
    return false;
  }

  return true;
}
_ValFecha  _esValidaFechaLatina(String fec,DateTime fechaDesde,DateTime fechaHasta) {
  //------------------------------------------
  _ValFecha rta= validaExpresionFechaLatina(fec);
  if(rta!=_ValFecha.IsOk) return rta;
  if(!esFechaLatina(fec)) return _ValFecha.FechaRara;
  DateTime f;


  f = new DateFormat.yMd().parseStrict(_cambioFormato(fec));

  if (f.isBefore(fechaDesde)) return _ValFecha.FechaMenor;
  if (fechaHasta.isBefore(f)) return _ValFecha.FechaMayor;
  return _ValFecha.IsOk;
}  //Tipo de fecha


/*
Ejemplo de llamada
  Se debe definir el controlador de la fecha
  TextEditingController ctrlFecha;

  void initState() {
    super.initState();
    DateTime f = DateTime.now();
    fechaInicial = DateTime(f.year,f.month,f.day);  //no es necesario el utc
    ctrlFecha.text=_formateoFecha(fechaInicial);

  }


  se llama posteriormente de un formulario

 return new SafeArea (
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: true,
          child: new ListView (
              children:
                 [
                  new FechaCalendario(
                    context:context,
                    fechaOk:(DateTime dtFec){
                      ctrlFecha.text=formateoFechaL(dtFec);
                      print(dtFec);
                    },
                    fechaDesde:new DateTime(2018, 08, 01),
                    fechaHasta:new DateTime(2021, 12, 31),
                    ctrlFecha:ctrlFecha,
                    hinText:"Fecha",
                    labelText:"F.de.compromiso:",

                  ),
              )
          )
        );
Usa las librerias  (puede que alguna sobre
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:validator/validator.dart' as val;

 */