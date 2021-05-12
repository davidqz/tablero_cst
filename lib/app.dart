import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pantallas/pantalla_inicio.dart';
import 'utilidades/constantes.dart';

class TableroCstApp extends StatelessWidget {
  const TableroCstApp();

  static const String rutaPrincipal = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tablero CST CIMAT',
      theme: ThemeData(
          primaryColor: kColorPrimario,
          accentColor: kColorSecundario,
          backgroundColor: kColorFondo),
      debugShowCheckedModeBanner: true,
      initialRoute: rutaPrincipal,
      routes: <String, WidgetBuilder>{
        rutaPrincipal: (context) => PantallaInicio(),
      },
    );
  }
}
