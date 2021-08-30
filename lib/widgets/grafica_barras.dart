import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../utilidades/constantes.dart';
import 'tarjeta_con_titulo.dart';

class GraficaBarras extends StatelessWidget {
  final String titulo;
  final Map<String, double> mapaDatos;
  final ColorPaleta11 colorPrincipal;
  final int flex;

  GraficaBarras({
    this.titulo = '',
    required this.mapaDatos,
    this.colorPrincipal = ColorPaleta11.turqueza,
    this.flex = 1,
  }) {
    final datos = <EtiquetaValor>[];
    mapaDatos.forEach((k, v) => datos.add(EtiquetaValor(k, v)));
    final tonosColores =
        _paleta11[colorPrincipal.index].makeShades(datos.length);
    _seriesList.add(charts.Series<EtiquetaValor, String>(
      id: titulo,
      colorFn: (_, i) => tonosColores[i ?? 0],
      domainFn: (e, _) => e.etiqueta,
      measureFn: (e, _) => e.valor,
      data: datos,
      labelAccessorFn: (e, _) => kFormatoCompacto.format(e.valor),
      insideLabelStyleAccessorFn: (_, i) => charts.TextStyleSpec(
          color: (i! / datos.length) >= 0.5
              ? charts.MaterialPalette.gray.shade800
              : charts.MaterialPalette.white),
    ));
  }

  static final _paleta11 = charts.MaterialPalette.getOrderedPalettes(11);
  final List<charts.Series<EtiquetaValor, String>> _seriesList = [];

  @override
  Widget build(BuildContext context) {
    return TarjetaConTitulo(
      titulo: titulo,
      flex: flex,
      widget: SizedBox(
        height: kAlturaGraficas,
        child: charts.BarChart(
          _seriesList,
          barRendererDecorator: charts.BarLabelDecorator<String>(),
          domainAxis: charts.OrdinalAxisSpec(),
          primaryMeasureAxis:
              charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
        ),
      ),
    );
  }
}

class EtiquetaValor {
  final String etiqueta;
  final double valor;

  EtiquetaValor(this.etiqueta, this.valor);
}

enum ColorPaleta11 {
  azul,
  rojo,
  amarillo,
  verde,
  morado,
  cian,
  naranja,
  lima,
  indigo,
  rosa,
  turqueza
}
