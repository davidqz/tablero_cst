import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pantallas/pantalla_autentificacion.dart';
import 'pantallas/pantalla_inicio.dart';
import 'utilidades/almacen_datos.dart';
import 'utilidades/constantes.dart';
import 'utilidades/rutas.dart';

void main() {
  runApp(TableroCstApp());
}

class TableroCstApp extends StatelessWidget {
  const TableroCstApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // Agregar las clases proovedoras que se deseen tener disponibles
        // en el arbol entero de widgets.
        providers: [
          ChangeNotifierProvider(create: (_) => AlmacenDatos()),
        ],
        child: MaterialApp(
          title: kTituloPaginaWeb,
          debugShowCheckedModeBanner: true,
          // initialRoute: rutaAutentificacion,
          initialRoute: rutaPrincipal,
          routes: <String, WidgetBuilder>{
            rutaPrincipal: (context) => PantallaInicio(),
            rutaAutentificacion: (context) => PantallaAutentificacion(),
          },
          theme: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: kColorPrimario,
              secondary: kColorSecundario,
              background: kColorFondo,
            ),
            primaryColor: kColorPrimario,
            accentColor: kColorSecundario,
            backgroundColor: kColorFondo,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: kColorSecundario,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [const Locale('es')],
        ));
  }
}
