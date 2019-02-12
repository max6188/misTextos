part of ifin;
/*
autor:Máximo Meza
correo; max82574971@gmail.com
github: max6188
Función:Obtencion de yf,dolar y euro para una fecha dada;
abajo forma de uso
*/

const urlIF =    "https://mindicador.cl/api/";
enum _TipoError{
  SinIntrumentoFinanciero,
  IndicadorNoDisponible,
  UnidadMedidaDifiere,
  MalParseoJson
}

List<String> _lErrores=[
  "Sin instrumento financiero",
  "Indicador no disponible",
  "Unidad de medida difiere",
  "Mal parseo Json"
];

enum TipoInstrumentoFinanciero {
  Peso,
  Uf,
  Dolar,
  Euro,
}




Future<double> valorInstrumentoFinanciero(TipoInstrumentoFinanciero tIF, DateTime dt) async {
  const List<String> lTipoIndicador = const ["Pesos", "uf", "dolar", "euro"];

  String _formoUrl() {
    //https://mindicador.cl/api/{tipo_indicador}/{dd-mm-yyyy}]
    StringBuffer url = new StringBuffer();
    url.write(urlIF);
    url.write(lTipoIndicador[tIF.index]);
    url.write("/");
    url.write((dt.day).toString());
    url.write("-");
    url.write(dt.month.toString());
    url.write("-");
    url.write(dt.year.toString());
    assert(url != null);
    return url.toString();
  }

  final String url = _formoUrl();
  try {
    final _IndicadorFinanciero iF = await _buscaIndicador(url);
    return iF.lSerie[0].valor;
  } catch (e) {
    throw Exception(
        '${_TipoError.MalParseoJson.index}==>${_lErrores[_TipoError.MalParseoJson.index]} ${"No hay valores para esta fecha"} ');
  }
}

Future<_IndicadorFinanciero> _buscaIndicador(String url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {

    return _IndicadorFinanciero.fromJson(json.decode(response.body));

  } else {
    throw Exception(
        '${_TipoError.IndicadorNoDisponible.index}==>${_lErrores[_TipoError.IndicadorNoDisponible.index]} ${response.statusCode} ');
  }
}

class _Serie {
  String fecha;
  double valor;

  _Serie({this.fecha, this.valor});

  factory _Serie.fromJson(Map<String, dynamic> json) {
    return _Serie(fecha: json['fecha'], valor: json['valor']);
  }
}

class _IndicadorFinanciero {
  /*
  https://flutter.io/cookbook/networking/fetch-data/
{
  "version": "1.5.0",
  "autor": "mindicador.cl",
  "codigo": "uf",
  "nombre": "Unidad de fomento (UF)",
  "unidad_medida": "Pesos",
  "serie": [
    {
      "fecha": "2018-07-07T04:00:00.000Z",
      "valor": 27177.76
    }
  ]
}
  */

  final String version;
  final String autor;
  final String codigo;
  final String nombre;
  final String unidadMedida;
  final List<_Serie> lSerie;

  _IndicadorFinanciero(
      {this.version,
      this.autor,
      this.codigo,
      this.nombre,
      this.unidadMedida,
      this.lSerie});

  factory _IndicadorFinanciero.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['serie'] as List;
    List<_Serie> serieList = list.map((i) => _Serie.fromJson(i)).toList();

    return _IndicadorFinanciero(
      version: json['version'],
      autor: json['autor'],
      codigo: json['codigo'],
      nombre: json['nombre'],
      unidadMedida: json['unidad_medida'],
      lSerie: serieList,
    );
  }
}


/*
Desde el llamador
 Future<bool> traeInstrumentos() async {
    try {
      vIF = await Future.wait([
        valorInstrumentoFinanciero(
            TipoInstrumentoFinanciero.Uf, _datoForm.fechaProceso),
        valorInstrumentoFinanciero(
            TipoInstrumentoFinanciero.Dolar, _datoForm.fechaProceso),
        valorInstrumentoFinanciero(
            TipoInstrumentoFinanciero.Euro, _datoForm.fechaProceso),
      ]);
    } catch (e|) {
      print(e.toString());
    }
    return true;
  }

  traeInstrumentos().then((rta) {
      setState(() {
        terminoTraida=rta;
      });

    });


 */