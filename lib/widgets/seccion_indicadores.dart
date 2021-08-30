import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import '../utilidades/constantes.dart';
import 'tarjeta_con_titulo.dart';

class SeccionIndicadores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
      builder: (_, almacen, __) => Row(
        children: [
          TarjetaConTitulo(
            flex: 1,
            titulo: 'Numero de servicios',
            texto: almacen.numServicios.toString(),
          ),
          TarjetaConTitulo(
            flex: 2,
            titulo: 'Suma de montos',
            texto: kFormatoMoneda.format(almacen.sumaMontos),
          ),
          TarjetaConTitulo(
            flex: 2,
            titulo: 'Suma de ingresos',
            texto: kFormatoMoneda.format(almacen.sumaIngresos),
          ),
          TarjetaConTitulo(
            flex: 2,
            titulo: 'Suma de egresos',
            texto: kFormatoMoneda.format(almacen.sumaEgresos),
          ),
        ],
      ),
    );
  }
}
