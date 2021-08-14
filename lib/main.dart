import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'utilidades/almacen_datos.dart';
import 'utilidades/rutas.dart';

void main() {
  runApp(const MainRouterApp());
}

class MainRouterApp extends StatelessWidget {
  const MainRouterApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Agregar las clases proovedoras que se deseen tener disponibles
          // en el arbol entero de widgets.
          ChangeNotifierProvider(create: (_) => AlmacenDatos()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteConfiguration.onGenerateRoute,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [const Locale('es')],
        ));
  }
}

class Path {
  const Path(this.pattern, this.builder);

  // A RegEx string for route matching.
  final String pattern;
  final Widget Function(BuildContext) builder;
}

// ignore: avoid_classes_with_only_static_members
class RouteConfiguration {
  static List<Path> paths = [
    Path(
      r'^' + rutaPrincipal,
      (context) => const TableroCstApp(),
    ),
    Path(
      r'^/',
      (context) => const TableroCstApp(),
    ),
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    for (final path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name ?? '')) {
        return MaterialPageRoute<void>(
          builder: path.builder,
          settings: settings,
        );
      }
    }
    return null;
  }
}
