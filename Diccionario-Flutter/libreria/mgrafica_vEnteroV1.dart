part of agenda;

/*
autor:Máximo Meza
correo; max82574971@gmail.com
github: max6188
Función: Lee un número;
abajo forma de uso
*/


class VEntero extends StatefulWidget {
  final TextEditingController numCtrl ;
  final String   hinText;                        //Indicacion del texto
  final String   labelText;                      //Label de la fecha
  final ValueSetter <int> numeroDevuelto ;
  final int lInferior;                         //>= que este valor
  final int lSuperior;                         //<= que este valor

   VEntero({this.hinText,this.labelText, this.numeroDevuelto,this.lInferior,this.lSuperior,this.numCtrl}); //Es numerico;




  @override
  State createState() => new _VEntero();
}

class _VEntero extends State<VEntero> {
  @override
  Widget build(BuildContext context) {
    return  new TextFormField(
        decoration: new InputDecoration(
          hintText: widget.hinText,
          labelText: widget.labelText,

        ),
        controller: widget.numCtrl,
        keyboardType: TextInputType.number,
        //inputFormatters: [WhitelistingTextInputFormatter. ],
        validator: (dat) {
            if(dat.isEmpty) return null;
           if(!val.isNumeric(dat)) return "Formato de número no es válido";
           int d= int.parse(dat);
           if(widget.lInferior>=d ) return "Número muy pequeño";
           if(widget.lSuperior<=d ) return "Número muy grande";
           return null;
        },
        onSaved:(val) {
          if(val.isNotEmpty) {
            int d = int.tryParse(val);
            if(d!=null) widget.numeroDevuelto(d);
          }
        }



    );


  }
}

/*
    new VEntero(
          hinText:"Número",
          labelText:"Monto a calcular",
          lInferior:0,
          numCtrl:numCtrl,
          lSuperior: 150,
          numeroDevuelto:(int rta){
          }
     ),
                              ),

 */
