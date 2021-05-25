import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

import '../utilidades/constantes.dart';
import 'datos.dart';

class ManejadorDatos extends ChangeNotifier {
  Datos _datos = Datos(servicios: []);

  ManejadorDatos() {
    _cargarDatos();
  }

  bool get datosCargados => _datos.servicios.isNotEmpty;

  int get totalServicios => _datos.servicios.length;

  int get numServiciosInternos =>
      _datos.servicios.where((s) => s.interno == 1).length;

  int get numServiciosAbiertos =>
      _datos.servicios.where((s) => s.estatus == 'Abierto').length;

  double get montosTotales {
    var suma = 0.0;
    for (var servicio in _datos.servicios) {
      suma += servicio.montoProyecto;
    }
    return suma;
  }

  Future _cargarDatos() async {
    print('Leyendo archivo: $kRutaDatosJson');
    final jsonString = await rootBundle.loadString(kRutaDatosJson);
    final mapa = json.decode(jsonString) as Map<String, dynamic>;
    _datos = Datos.fromJson(mapa);
    notifyListeners();
  }
}
