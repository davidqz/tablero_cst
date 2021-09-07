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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            BannerSuperior(),
            Expanded(
              child: Provider.of<AlmacenDatos>(context).datosListos
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 16.0,
                      ),
                      child: Column(
                        children: [
                          SeccionFiltros(),
                          SeccionIndicadores(),
                          SeccionGraficas(),
                          TablaDeColumnas(),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
