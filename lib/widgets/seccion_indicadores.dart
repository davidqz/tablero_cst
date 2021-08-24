import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import 'tarjeta_con_titulo.dart';

final _formatoMoneda = NumberFormat.simpleCurrency();

class SeccionIndicadores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
      builder: (_, almacen, __) => Row(
        children: [
          TarjetaConTitulo(
            titulo: 'Numero de servicios',
            child: Text(
              '${almacen.numServicios}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          TarjetaConTitulo(
            titulo: 'Suma de montos',
            child: Text(
              _formatoMoneda.format(almacen.sumaMontos),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          TarjetaConTitulo(
            titulo: 'Suma de ingresos',
            child: Text(
              _formatoMoneda.format(almacen.sumaIngresos),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          TarjetaConTitulo(
            titulo: 'Suma de egresos',
            child: Text(
              _formatoMoneda.format(almacen.sumaEgresos),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
