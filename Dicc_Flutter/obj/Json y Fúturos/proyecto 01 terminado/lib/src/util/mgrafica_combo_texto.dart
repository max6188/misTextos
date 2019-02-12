part of presupuesto;
/*
para llamar

 List <String>_fruits = ["Apple", "Banana", "Pineapple", "Mango", "Grapes"];

 new Combo(
                    lCosas:_fruits,
                    primerValor:"Banana",
                    onGetDD:valSeleccionado,
                  )

 La función que devuelve el campo es
  void valSeleccionado(String vCombo){
    print("vCombo=$vCombo" );
  }

 */

class Combo extends StatefulWidget {
  final List<String> lCosas;
  final String primerValor;
  final ValueSetter<String> onGetDD;



  Combo({this.lCosas, this.onGetDD,this.primerValor}) ;


  @override
  State<StatefulWidget> createState() => new _Combo();
}

class _Combo extends State<Combo> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedFruit;

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(widget.lCosas);
    _selectedFruit =widget.primerValor==null?_dropDownMenuItems[0].value:widget.primerValor;
   }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String value) {
    _selectedFruit=value;
    widget.onGetDD(value);
  }




  @override
  Widget build(BuildContext context) {
    return new DropdownButton(
      value: _selectedFruit,
      items: _dropDownMenuItems,
      onChanged: changedDropDownItem,
    );
  }
}