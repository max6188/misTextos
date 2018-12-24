part of presupuesto;

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

