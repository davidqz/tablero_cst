import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import '../widgets/banner_superior.dart';
import '../widgets/filtros.dart';
import '../widgets/indicadores.dart';
import '../widgets/tabla_de_columnas.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<AlmacenDatos>(
        builder: (_, almacen, __) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            children: [
              BannerSuperior(),
              Expanded(
                child: Card(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Filtros(),
                        Indicadores(),
                        Expanded(
                          child: almacen.datosListos
                              ? TablaDeColumnas(
                                  key: UniqueKey(),
                                  datosTabla: almacen.datosTablaServicios,
                                  encabezadosColumna: almacen
                                      .datosTablaServicios.encabezadosColumnas,
                                )
                              : Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
