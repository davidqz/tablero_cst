import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'constantes.dart';
import 'datos_tabla_servicios.dart';
import 'modelo_datos_json.dart';

class AlmacenDatos extends ChangeNotifier {
  // Inicializamos _datos con una lista de servicios vacia para evitar problemas
  // con null al cargar la applicacion.
  DatosJson _datos = DatosJson(servicios: []);

  late DatosTablaServicios datosTablaServicios;

  AlmacenDatos() {
    _cargarArchivoJson();
  }

  Future _cargarArchivoJson() async {
    print('Leyendo archivo: $kRutaDatosJson');
    final jsonString =
        await rootBundle.loadString(kRutaDatosJson, cache: false);
    final mapa = json.decode(jsonString) as Map<String, dynamic>;
    _datos = DatosJson.fromJson(mapa);
    _crearTablas();
    notifyListeners();
  }

  void _crearTablas() {
    datosTablaServicios = DatosTablaServicios(servicios: servicios);
    _datosListos = true;
  }

  bool _datosListos = false;

  get datosListos => _datosListos;

  List<Servicio> get servicios => _datos.servicios;

  int get totalServicios => servicios.length;

  int get numServiciosInternos => servicios.where((s) => s.interno == 1).length;

  int get numServiciosAbiertos =>
      servicios.where((s) => s.estatus == 'Abierto').length;

  // double get montosTotales {
  //   var suma = 0.0;
  //   for (var servicio in servicios) {
  //     suma += servicio.montoProyecto;
  //   }
  //   return suma;
  // }
}
