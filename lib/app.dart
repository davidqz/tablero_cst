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
        iconTheme: const IconThemeData(
          color: kColorIconos,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          isDense: true,
          filled: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: kColorSecundario,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        chipTheme: ChipTheme.of(context).copyWith(
          backgroundColor: Colors.black26,
          elevation: 2,
          selectedColor: kColorSecundario,
          checkmarkColor: Colors.white,
          labelStyle: ThemeData.fallback()
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
