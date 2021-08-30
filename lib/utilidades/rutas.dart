import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app.dart';

const String rutaAutentificacion = '/autentificacion';
const String rutaPrincipal = '/principal';

// ignore: avoid_classes_with_only_static_members
class RouteConfiguration {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (context) => const TableroCstApp(),
      settings: settings,
    );
  }
}
