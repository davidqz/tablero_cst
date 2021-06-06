import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import '../widgets/banner_superior.dart';
import '../widgets/tablero_principal.dart';

class PantallaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(children: [
        BannerSuperior(),
        Expanded(
          child: Provider.of<AlmacenDatos>(context).almacenEstaVacio
              ? Center(child: CircularProgressIndicator())
              : TableroPrincipal(),
        ),
      ]),
    );
  }
}
