part of presupuesto;

const urlIF =    "https://mindicador.cl/api/";
enum TipoInstrumentoFinanciero {
  Peso,
  Uf,
  Dolar,
  Euro,
}

List <String> descripcionTipoInstrumentoFinanciero=[
  "Pesos.",
  "U.F.  :",
  "Dólar.:",
  "Euro. :"
];

enum Formatos{
  FechaLatina,
  FechaUsa
}