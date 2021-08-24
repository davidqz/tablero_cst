import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import '../utilidades/constantes.dart';
import 'tarjeta_con_titulo.dart';

class SeccionGraficas extends StatefulWidget {
  SeccionGraficas();

  @override
  _SeccionGraficasState createState() => _SeccionGraficasState();
}

class _SeccionGraficasState extends State<SeccionGraficas> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
      builder: (_, almacen, __) => Row(
        children: [
          SimpleBarChart.conMontoSede('Montos por sede', almacen.montosPorSede),
          SimpleBarChart.conMontoSede(
              'Ingresos por año', almacen.ingresosPorAnyo),
          SimpleBarChart.conMontoSede(
              'Egresos por año', almacen.egresosPorAnyo),
        ],
      ),
    );
  }
}

class SimpleBarChart extends StatelessWidget {
  final String titulo;
  final List<charts.Series<dynamic, String>> seriesList;

  SimpleBarChart(this.titulo, this.seriesList);

  factory SimpleBarChart.conMontoSede(String titulo, Map<String, double> mapa) {
    return SimpleBarChart(titulo, _crearSerieMontoSede(titulo, mapa));
  }

  @override
  Widget build(BuildContext context) {
    return TarjetaConTitulo(
      titulo: titulo,
      child: SizedBox(
        height: kPixelesDeAlturaGraficas,
        child: charts.BarChart(
          seriesList,
          barRendererDecorator: charts.BarLabelDecorator<String>(),
          domainAxis: charts.OrdinalAxisSpec(),
        ),
      ),
    );
  }

  static List<charts.Series<StringDouble, String>> _crearSerieMontoSede(
      String titulo, Map<String, double> mapa) {
    final datos = <StringDouble>[];
    mapa.forEach((sede, monto) {
      datos.add(StringDouble(sede, monto));
    });
    final colorShades = charts.MaterialPalette.teal.makeShades(datos.length);
    return [
      charts.Series<StringDouble, String>(
          id: titulo,
          colorFn: (montoSede, __) => colorShades[
              datos.indexWhere((d) => montoSede.etiqueta == d.etiqueta)],
          domainFn: (montoSede, _) => montoSede.etiqueta,
          measureFn: (montoSede, _) => montoSede.valor,
          data: datos,
          labelAccessorFn: (montoSede, _) =>
              '\$${montoSede.valor.toInt().toString()}'),
    ];
  }
}

class StringDouble {
  final String etiqueta;
  final double valor;

  StringDouble(this.etiqueta, this.valor);
}
