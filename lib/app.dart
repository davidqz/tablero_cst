import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pantallas/pantalla_inicio.dart';
import 'utilidades/constantes.dart';

class TableroCstApp extends StatelessWidget {
  const TableroCstApp();

  static const String rutaPrincipal = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tablero CST CIMAT',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light().copyWith(
            primary: kColorPrimario,
            secondary: kColorSecundario,
        ),
        primaryColor: kColorPrimario,
        backgroundColor: kColorFondo,
        inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: kColorSecundario,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ),
      // theme: ThemeData.dark().copyWith(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('es')],
      debugShowCheckedModeBanner: true,
      initialRoute: rutaPrincipal,
      routes: <String, WidgetBuilder>{
        rutaPrincipal: (context) => PantallaInicio(),
      },
    );
  }
}
