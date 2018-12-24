part of presupuesto;


class VCadena extends StatelessWidget {
  final TextEditingController textoCtrl ;
  final Key textoKey;
  final String hintText;
  final ValueSetter<String> doydescripcion;

  VCadena({this.textoCtrl, this.textoKey, this.hintText, this.doydescripcion});

  @override
  Widget build(BuildContext context) {
  return new TextField(
  key: textoKey,
  controller: textoCtrl,
  decoration: new InputDecoration(hintText: hintText),
  onSubmitted: (String value) {
  // Notify that we're adding a new item, and clear the text field
     this.doydescripcion(value);

  });}
 }