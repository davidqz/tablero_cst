import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/manejador_datos.dart';
import '../widgets/banner_superior.dart';
import '../widgets/tablero_principal.dart';

class PantallaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(children: [
        BannerSuperior(),
        MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ManejadorDatos()),
            ],
            builder: (context, child) {
              return Expanded(
                  child: Provider.of(context)<ManejadorDatos>().datosCargados
                      ? TableroPrincipal()
                      : Center(child: CircularProgressIndicator()));
            }),
      ]),
    );
  }
}
