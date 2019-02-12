part of ifin;

/*
autor:Máximo Meza
correo; max82574971@gmail.com
github: max6188
Función: Lee un número;
abajo forma de uso
*/


class VDouble extends StatefulWidget {
  final String   hinText;                        //Indicacion del texto
  final String   labelText;                      //Label de la fecha
  final ValueSetter <double> numeroDevuelto ;
  final double lInferior;                         //>= que este valor
  final double lSuperior;                         //<= que este valor

  VDouble({this.hinText, this.labelText, this.numeroDevuelto,this.lInferior,this.lSuperior}); //Es numerico;




  @override
  State createState() => new _VDouble();
}

class _VDouble extends State<VDouble> {
  @override
  Widget build(BuildContext context) {
    return  new TextFormField(
        decoration: new InputDecoration(
          hintText: widget.hinText,
          labelText: widget.labelText,

        ),
        //controller: ctrlFecha,
        keyboardType: TextInputType.number,
        //inputFormatters: [WhitelistingTextInputFormatter. ],
        validator: (dat) {
            if(dat.isEmpty) return null;
           if(!val.isNumeric(dat)) return "Formato de número no es válido";
           double d= double.parse(dat);
           if(widget.lInferior>=d ) return "Número muy pequeño";
           if(widget.lSuperior<=d ) return "Número muy grande";
           return null;
        },
        onSaved:(val) {
          if(val.isNotEmpty) {
            double d = double.tryParse(val);
            if(d!=null) widget.numeroDevuelto(d);
          }
        }



    );


  }
}

/*
    new VDouble(
          hinText:"Número",
          labelText:"Monto a calcular",
          lInferior:0.0,
          lSuperior: double.infinity,
          numeroDevuelto:(double rta){
          }
                              ),

 */
