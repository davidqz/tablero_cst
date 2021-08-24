import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import '../widgets/banner_superior.dart';
import '../widgets/seccion_filtros.dart';
import '../widgets/seccion_graficas.dart';
import '../widgets/seccion_indicadores.dart';
import '../widgets/tabla_de_columnas.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<AlmacenDatos>(
        builder: (_, almacen, __) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BannerSuperior(),
              Expanded(
                child: Card(
                  color: Colors.grey[200],
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SeccionFiltros(),
                        SeccionIndicadores(),
                        SeccionGraficas(),
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
