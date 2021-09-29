import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import '../widgets/banner_superior.dart';
import '../widgets/seccion_filtros.dart';
import '../widgets/seccion_graficas.dart';
import '../widgets/seccion_indicadores.dart';
import '../widgets/tabla_columnas.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const BannerSuperior(),
            Expanded(
              child: Provider.of<AlmacenDatos>(context).datosListos
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 16.0,
                      ),
                      child: Column(
                        children: const [
                          SeccionFiltros(),
                          SeccionIndicadores(),
                          SeccionGraficas(),
                          TablaColumnas(),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
