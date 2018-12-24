part of cliente;
/*
autor:Máximo Meza
correo; max82574971@gmail.com
github: max6188
Función: Tipos de datos ;
abajo forma de uso
*/


class NombreTD  extends StatelessWidget {
  final Key fieldKey;
  final bool esNulo;
  final int   largo;
  final String concepto;
  final String valorInicial;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;


  NombreTD({this.fieldKey, this.esNulo,this.largo, this.concepto,this.valorInicial,this.onSaved, this.onFieldSubmitted});

  String _validaNombre(String value) {
    if(esNulo &&value.isEmpty) return null;
    if (value.isEmpty)
      return '$concepto es requerido .';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Solamente letras.';
    return null;
  }
   @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key:fieldKey,
      maxLength: largo,
      onSaved: onSaved,
      initialValue:valorInicial,
      validator: _validaNombre,
      onFieldSubmitted: onFieldSubmitted,
      decoration: new InputDecoration(
            border: const UnderlineInputBorder(),
            filled: true,
            icon: const Icon(MdiIcons.contacts),
            hintText: "Ingrese $concepto",
            labelText: "$concepto",
            helperText: "Máximo $largo carácteres",
            //suffixIcon:  const Icon(MdiIcons.contacts),
      ),
      keyboardType: TextInputType.text,
    );

  }
}

class FonoTD  extends StatelessWidget {
  final Key fieldKey;
  final bool esNulo;
  final int   largo;
  final String concepto;
  final String valorInicial;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;


  FonoTD({this.fieldKey, this.esNulo,this.largo, this.concepto,this.valorInicial,this.onSaved, this.onFieldSubmitted});

  String _validaFono(String value) {
    //09.8257.5971
    if(esNulo &&value.isEmpty) return null;
    final RegExp phoneExp = new RegExp(r'^\(\d\d\)\d\d\d\d\.\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '(##) ####.#### - Entra un múmero de teléfono.';
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key:fieldKey,
      maxLength: largo,
      initialValue:valorInicial,
      onSaved: onSaved,
      validator: _validaFono,
      onFieldSubmitted: onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        icon: const Icon(MdiIcons.phone),
        hintText: "Ingrese $concepto",
        labelText: "$concepto",
        //helperText: "Máximo $largo carácteres",
      ),
      keyboardType: TextInputType.phone,

    );

  }
}

class CorreoTD  extends StatelessWidget {
  final Key fieldKey;
  final bool esNulo;
  final int   largo;
  final String concepto;
  final String valorInicial;

  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;

  CorreoTD({this.fieldKey, this.esNulo,this.largo, this.concepto,this.valorInicial,this.onSaved, this.onFieldSubmitted});


  String validaCorreo(String value) {
    if(esNulo &&value.isEmpty) return null;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Entre correo válido';
    else
      return null;
  }
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key:fieldKey,
      maxLength: largo,
      initialValue:valorInicial,
      onSaved: onSaved,
      validator: validaCorreo,
      onFieldSubmitted: onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        icon: const Icon(MdiIcons.email),
        hintText: "Ingrese $concepto",
        labelText: "$concepto",
        helperText: "Máximo $largo carácteres",
      ),
      keyboardType: TextInputType.emailAddress,

    );

  }
}

class OtroTD  extends StatelessWidget {
  final Key fieldKey;
  final bool esNulo;
  final int   largo;
  final String concepto;
  final String valorInicial;
  final Widget icono;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;

  OtroTD({this.fieldKey, this.esNulo,this.largo, this.concepto,this.valorInicial,this.icono,this.onSaved, this.onFieldSubmitted});

  String validaDummy(String value) {

    if(esNulo &&value.isEmpty) return null;
    if (value.isEmpty)
      return '$concepto es requerido .';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key:fieldKey,
      maxLength: largo,
      initialValue:valorInicial,
      onSaved: onSaved,
      validator: validaDummy,
      onFieldSubmitted: onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        icon: icono,
        hintText: "Ingrese $concepto",
        labelText: "$concepto",
        helperText: "Máximo $largo carácteres",
      ),
      keyboardType: TextInputType.text,

    );

  }
}


class DescripcionTD  extends StatelessWidget {
  final Key fieldKey;
  final bool esNulo;
  final int   largo;
  final String concepto;
  final String valorInicial;
  final int maxLineas;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;

  DescripcionTD({this.fieldKey, this.esNulo,this.largo, this.concepto,this.valorInicial,this.maxLineas,this.onSaved, this.onFieldSubmitted});

  String validaDummy(String value) {

    if(esNulo &&value.isEmpty) return null;
    if (value.isEmpty)
      return '$concepto es requerido .';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key:fieldKey,
      maxLength: largo,
      initialValue:valorInicial,
      maxLines:maxLineas,
      onSaved: onSaved,
      validator: validaDummy,
      onFieldSubmitted: onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        icon: const Icon(MdiIcons.note),
        hintText: "Ingrese $concepto",
        labelText: "$concepto",
        helperText: "Máximo $largo carácteres",
      ),
      keyboardType: TextInputType.text,

    );

  }
}


/*
 NombreTD(
                          fieldKey:fieldKeyNombre,
                          esNulo:false,
                          concepto:"nombre",
                          valorInicial:dCon.nombre,
                          largo:40,
                          onSaved:(String nombre) { dCon.nombre = nombre; },
                          onFieldSubmitted:(String nombre) => setState(() {
                                      dCon.nombre = nombre;
                          }),
                      ), //nombre,
  FonoTD(
                        fieldKey:fieldKeyFono,
                        esNulo:true,
                        concepto:"fono",
                        valorInicial:dCon.fono,
                        largo:40,
                        onSaved:(String fono) { dCon.fono = fono; },
                        onFieldSubmitted:(String fono) => setState(() {
                          dCon.fono = fono;
                        }),
                      ), //fono
  CorreoTD(
                        fieldKey:fieldKeyCorreo,
                        esNulo:true,
                        concepto:"correo",
                        valorInicial:dCon.correo,
                        largo:40,
                        onSaved:(String correo) { dCon.correo = correo; },
                        onFieldSubmitted:(String correo) => setState(() {
                          dCon.correo = correo;
                        }),
                      ),
 DescripcionTD(
                        fieldKey:fieldKeyDescripcion,
                        esNulo:true,
                        concepto:"fono",
                        valorInicial:dCon.descripcion,
                        //largo:40,
                        maxLineas: 5,
                        onSaved:(String des) { dCon.descripcion = des; },
                        onFieldSubmitted:(String des) => setState(() {
                          dCon.descripcion = des;
                        }),
                      ),
                       OtroTD(
                        fieldKey:fieldKeyAsunto,
                        esNulo:false,
                        concepto:"Asunto",
                        valorInicial:dCon.asunto,
                        largo:40,
                        onSaved:(String as) { dCon.asunto = as; },
                        onFieldSubmitted:(String as) => setState(() {
                          dCon.asunto = as;
                        }),
                        icono:const Icon(MdiIcons.assistant),
                      ),
 */