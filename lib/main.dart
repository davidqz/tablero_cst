import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'utilidades/almacen_datos.dart';
import 'utilidades/rutas.dart';

void main() {
  configureApp();
  runApp(const MainRouterApp());
}

class MainRouterApp extends StatelessWidget {
  const MainRouterApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Agregar las clases proovedoras que se deseen tener disponibles
          // en el arbol de widgets.
          ChangeNotifierProvider(create: (_) => AlmacenDatos()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteConfiguration.onGenerateRoute,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [const Locale('es', 'MX')],
        ));
  }
}
