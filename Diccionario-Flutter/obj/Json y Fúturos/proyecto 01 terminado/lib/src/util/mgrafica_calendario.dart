part of presupuesto;

/*
Autor: Maximo Meza c
Fecha : 15/7/2018
Asunto: Ingreso de fecha con calendario
Abajo explicacion
*/


enum _ValFecha{
    IsOk,
    DiaMayor31,
    MesMayor12,
    FechaMenor,
    FechaMayor,
}
List<String> _mjeError=[
    "",
    "Día mayor de 31",
    "Mes mayor que 12",
    "Fecha menor del rango sollicitado",
    "Fecha mayor del rango solicitado",
];

class CFechas {
  List<int> ahora =[0,0,0];
  DateTime fechaInicial;
  DateTime fechaFinal;
  Formatos fto;
  String hinText;
  String labelText;




  CFechas({this.fechaInicial, this.fechaFinal,
    this.fto,this.hinText,this.labelText}):
      assert(fechaInicial!=null),
      assert(fechaFinal!=null),
      assert(fto!=null),
      assert(hinText!=null),
      assert(labelText!=null);

  Future _escogeFecha(BuildContext context, seteoController(String tFex)) async {
    var result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: fechaInicial,
        lastDate: fechaFinal);

    if (result == null) return;
    //
    String nFec;
    if (fto == Formatos.FechaUsa) {
      nFec = new DateFormat.yMd().format(result);
    } else {
      nFec = "${result.day}/${result.month}/${result.year}";
    }
    seteoController(nFec);

  }

  Widget nDia(int dia){
    ahora[0]=dia;
    String sDia=dia.toString();
    return new Flexible (child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Día',
          ),
          initialValue: sDia,
          inputFormatters: [new LengthLimitingTextInputFormatter(2)],

          validator: (val) => sDia.isEmpty ? 'Día es requerido' : null,
          onSaved: (val) => ahora[0] = int.parse(val),
    ));
  }

  Widget   nMes(int mes){
    ahora[1]=mes;
    String sMes=mes.toString();
    return  new Flexible (child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Mes',
          ),
          initialValue: sMes,
          inputFormatters: [new LengthLimitingTextInputFormatter(2)],
          validator: (val) => sMes.isEmpty ? 'Día es requerido' : null,
          onSaved: (val) => ahora[1] = int.parse(val),
        ));
    }

  Widget  nAno(int ano){
    ahora[2]=ano;
    String sAno=ano.toString();
    return  new Flexible (child:  TextFormField(
          decoration: const InputDecoration(
            hintText: 'Año',
          ),
          initialValue: sAno,
          inputFormatters: [new LengthLimitingTextInputFormatter(2)],
          validator: (val) => sAno.isEmpty ? 'Día es requerido' : null,
          onSaved: (val) => ahora[2] = int.parse(val),

    ));
  }

  Widget ftoFecha(TextEditingController _controller, DateTime pFec,graboFecha(DateTime dt)) {
        return new Expanded(
        child: new TextFormField(
            decoration: new InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: this.hinText,
              labelText: this.labelText,
            ),
            controller: _controller,
            //initialValue: sFec,
            keyboardType: TextInputType.datetime,
           // inputFormatters: [new _DateFormatter()],
            validator: (val) {
              int rta =_esValidaFecha(val);
              return rta==0
                  ? null
                  : _mjeError[rta];

            },
            onSaved:(val) => graboFecha(_aFecha(val)),



        ));
  }

  Widget botonCalendario(BuildContext context, seteoController(String mifec)) {
    return new IconButton(
      icon: new Icon(Icons.more_horiz),
      tooltip: 'Escoger Fecha',
      onPressed: (() {
        _escogeFecha(context, seteoController);
      }),
    );
  }

  Widget botonFecha(BuildContext context, seteoController(String mifec)) {
    return new IconButton(
      icon: new Icon(Icons.date_range),
      tooltip: 'Calcular',
      onPressed: (() {
        String fec;
        if(fto==Formatos.FechaUsa)  fec="${ahora[1]}/${ahora[0]}/${ahora[2]}";
        else fec="${ahora[0]}/${ahora[1]}/${ahora[2]}";

        seteoController(fec);
      }),
    );
  }

  List <int> _trozeaFecha(miFec){
    List <String> lf= miFec.split("/");
    List<int> num=[];
    for(String s in lf) {
      if(s.length!=0) num.add(int.parse(s));
    }
    return num;
  }

  int  _esValidaFecha(String fec) {
     if (fec.isEmpty) return _ValFecha.IsOk.index;
      if(!fec.contains("/")) return _ValFecha.IsOk.index;
      DateTime f;

      //Tomo un arreglo de numeros lo parseo y valido cada parte
      List <int> fecNum = _trozeaFecha (fec);
      if(fto==Formatos.FechaUsa) {
        if (fecNum.length >= 1 && fecNum[0] > 12)
          return _ValFecha.MesMayor12.index;
        if (fecNum.length >= 2 && fecNum[1] > 31)
          return _ValFecha.DiaMayor31.index;
        if (fecNum.length >= 3 && fecNum[2] < 2000) return _ValFecha.IsOk.index;
        if (fecNum.length < 3 ) return _ValFecha.IsOk.index;

        f = new DateFormat.yMd().parseStrict(fec);
      } else {
        if (fecNum.length >= 1 && fecNum[0] > 31)
          return _ValFecha.DiaMayor31.index;
        if (fecNum.length >= 2 && fecNum[1] > 12)
          return _ValFecha.MesMayor12.index;

        if (fecNum.length >= 3 && fecNum[2] < 2000) return _ValFecha.IsOk.index;
        if (fecNum.length < 3 ) return _ValFecha.IsOk.index;
        String nFec = "${fecNum[1]}/${fecNum[0]}/${fecNum[2]}";
        f = new DateFormat.yMd().parseStrict(nFec);
      }
      if (f.isBefore(fechaInicial)) return _ValFecha.FechaMenor.index;
      if (fechaFinal.isBefore(f)) return _ValFecha.FechaMayor.index;
      return _ValFecha.IsOk.index;
  }


  DateTime _aFecha(String input) {
    try
    {

      if(fto==Formatos.FechaUsa) {
        DateTime d = new DateFormat.yMd().parseStrict(input);
        return d;
      }else {
        List <String> lf= input.split("/");
        String nFec = "${lf[1]}/${lf[0]}/${lf[2]}";
        return new DateFormat.yMd().parseStrict(nFec);
      }
    } catch (e) {


      return null;
    }
  }

}

/*
Se debe instanciar la clase CFechas, que no admite valores nulos
CFechas fec =new CFechas(
            fechaInicial:DateTime(2018,07,01),
            fechaFinal:DateTime(2018,07,30),
            fto:Formatos.FechaLatina,
            hinText:"Fecha de Instrumento",
            labelText:"Fecha"
            );
Se debe definir un controlador para la fecha y asignarle el valor inicial.
final TextEditingController _controller = new TextEditingController();
if(_controller.text==null)
      _controller.text ="${_datoForm.fechaProceso.day}/
                         ${_datoForm.fechaProceso.month}/
                         ${_datoForm.fechaProceso.year}";

Se llama finalmente como
new Row(
  children: [
    fec.ftoFecha(_controller, _datoForm.fechaProceso, graboFecha),
    fec.botonCalendario(context, seteoFecha),
  ],
),
Donde graboFecha y _seteoController son dos funciones que deben se proporciondas. GraboFecha obtiene el valor final y seteo administra el estado

_seteoController
(String miFec) {
  setState(() {
    _controller.text = miFec;
  });
}
void _graboFecha(DateTime dt) {
  _datoForm.fechaProceso = dt;
}

 */

