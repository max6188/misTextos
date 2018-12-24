part of presupuesto;

const urlIF =    "https://mindicador.cl/api/";
enum TipoInstrumentoFinanciero {
  Peso,
  Uf,
  Dolar,
  Euro,
}

enum TipoError{
  SinIntrumentoFinanciero,
  IndicadorNoDisponible,
  UnidadMedidaDifiere,
  MalParseoJson
}

List<String> lErrores=[
  "Sin instrumento financiero",
  "Indicador no disponible",
  "Unidad de medida difiere",
  "Mal parseo Json"
];