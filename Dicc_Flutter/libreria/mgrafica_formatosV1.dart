part of presupuesto;


String formatoDouble(double d) {
  final formatter = new NumberFormat("###,###.00");
  return formatter.format(d);
}

String formatoDoubleEntero(double d) {
  int i=d.truncate();
  final formatter = new NumberFormat("###,###");
  return formatter.format(i);
}
