import 'package:flutter/material.dart';

import 'pantallas/pantalla_autentificacion.dart';
import 'pantallas/pantalla_principal.dart';
import 'utilidades/constantes.dart';
import 'utilidades/rutas.dart';

class TableroCstApp extends StatelessWidget {
  const TableroCstApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kTituloPaginaWeb,
      initialRoute: rutaAutentificacion,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        rutaPrincipal: (context) => const PantallaPrincipal(),
        rutaAutentificacion: (context) => const PantallaAutentificacion(),
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
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ),
    );
  }
}
