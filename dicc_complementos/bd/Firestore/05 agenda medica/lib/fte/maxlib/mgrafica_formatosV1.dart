part of agenda;


String formatoDouble(double d) {
  final formatter = new NumberFormat("###,###.00");
  return formatter.format(d);
}

String formatoDoubleEntero(double d) {
  int i=d.truncate();
  final formatter = new NumberFormat("###,###");
  return formatter.format(i);
}

String _enteroStr(int n,String fto){
  final formatter = new NumberFormat(fto);
  return formatter.format(n);
}


String formateoFechaL(DateTime f){
  return "${f.day.toString()}/${f.month.toString()}/${f.year.toString()}";

}


String formateoFechaYYYYmmdd(DateTime f){
  return _enteroStr(f.year,"0000")+_enteroStr(f.month,"00")+_enteroStr(f.day,"00");
}

DateTime extraigoFechaYYYYmmdd(String s){
   return DateTime(int.parse(s.substring(0,4)),
           int.parse(s.substring(4,6)),
           int.parse(s.substring(6,8)));
}

  DateTime destrStamp(String s){
  //yyyy-mm-dd....}
    return DateTime(int.parse(s.substring(0,4)),int.parse(s.substring(5,7)),int.parse(s.substring(8,10)));
  }