part of agenda;




void dbInsertaRegistro(DatosAgenda d,String nombreDB){
  Firestore.instance.runTransaction((Transaction transaction) async {
    CollectionReference reference =Firestore.instance.collection(nombreDB);
    await reference.add({
      "donde": d.donde,
      "que": d.que,
      "quien": d.quien,
      "cuando": d.cuando,
      "vencida": d.vencida,
      "asunto": d.asunto,
      "nota": d.nota});
  });
}

void dbInsertaInyeccion(InyeccionFrm d,String nombreDB){
  Firestore.instance.runTransaction((Transaction transaction) async {
    CollectionReference reference =Firestore.instance.collection(nombreDB);
    await reference.add({
      "donde": "Otro",
      "que": "Inyeccion",
      "quien": "Max",
      "cuando": d.cuando,
      "vencida": 0,
      "asunto": d.asunto,
      "nota": d.nota});
  });
}


void dbModificaAgenda(DatosAgenda d,String nombreDB,String key) {
  Firestore.instance.collection(nombreDB).document(key).setData({
    "donde": d.donde,
    "que": d.que,
    "quien": d.quien,
    "cuando":d.cuando,
    "vencida": d.vencida,
    "asunto": d.asunto,
    "nota": d.nota
  });



}