import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import 'grafica_barras.dart';

class SeccionGraficas extends StatelessWidget {
  const SeccionGraficas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
      builder: (_, almacen, __) => Row(
        children: [
          GraficaBarras(
            flex: 3,
            titulo: 'Montos por sede',
            mapaDatos: almacen.montosPorSede,
            colorPrincipal: ColorPaleta11.turqueza,
          ),
          GraficaBarras(
            flex: 4,
            titulo: 'Ingresos por año',
            mapaDatos: almacen.ingresosPorAnyo,
            colorPrincipal: ColorPaleta11.verde,
          ),
          GraficaBarras(
            flex: 4,
            titulo: 'Egresos por año',
            mapaDatos: almacen.egresosPorAnyo,
            colorPrincipal: ColorPaleta11.rojo,
          ),
        ],
      ),
    );
  }
}
