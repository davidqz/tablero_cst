import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import 'indicador_texto.dart';

final _formatoMoneda = NumberFormat.simpleCurrency();

class Indicadores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
      builder: (_, almacen, __) => Row(
        children: [
          IndicadorTexto(
            etiqueta: 'Servicios Abiertos',
            texto: '${almacen.numServiciosAbiertos}',
          ),
          IndicadorTexto(
            etiqueta: 'Suma de montos',
            texto: _formatoMoneda.format(almacen.sumaMontos),
          ),
          IndicadorTexto(
            etiqueta: 'Suma de ingresos',
            texto: _formatoMoneda.format(almacen.sumaIngresos),
          ),
          IndicadorTexto(
            etiqueta: 'Suma de egresos',
            texto: _formatoMoneda.format(almacen.sumaEgresos),
          ),
        ],
      ),
    );
  }
}
