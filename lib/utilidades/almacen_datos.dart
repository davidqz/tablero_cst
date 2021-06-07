import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart' show NumberFormat;

import 'constantes.dart';
import 'modelo_datos_json.dart';

class AlmacenDatos extends ChangeNotifier {
  // Inicializamos _datos con una lista de servicios vacia para evitar problemas
  // con null al cargar la applicacion.
  DatosJson _datos = DatosJson(servicios: []);
  final _formatoMoneda = NumberFormat.simpleCurrency();

  AlmacenDatos() {
    _cargarArchivoJson();
  }

  Future _cargarArchivoJson() async {
    print('Leyendo archivo: $kRutaDatosJson');
    final jsonString =
        await rootBundle.loadString(kRutaDatosJson, cache: false);
    final mapa = json.decode(jsonString) as Map<String, dynamic>;
    _datos = DatosJson.fromJson(mapa);
    notifyListeners();
  }

  final _encabezadosColumnasTablaServicios = {
    'idServicio': 'ID',
    'clave': 'Clave',
    'estatus': 'Estatus',
    'nombreCorto': 'Nombre',
    'montoProyecto': 'Monto',
    // 'ingresos' : 'Ingresos',
    // 'gastos' : 'Gastos',
    'sede': 'Sede Responsable',
  };

  final encabezadosCulumnasNumericos = [
    'Monto',
  ];

  Iterable<String> get encabezadosColumnasTablaServicios =>
      _encabezadosColumnasTablaServicios.values;

  Iterable<Iterable<String>> get datosRenglones => servicios.map((servicio) => [
        servicio.idServicio,
        servicio.clave,
        servicio.estatus,
        servicio.nombreCorto,
        _formatoMoneda.format(servicio.montoProyecto),
        servicio.sede,
      ]);

  List<Servicio> get servicios => _datos.servicios;

  bool get almacenEstaVacio => servicios.isEmpty;

  int get totalServicios => servicios.length;

  int get numServiciosInternos => servicios.where((s) => s.interno == 1).length;

  int get numServiciosAbiertos =>
      servicios.where((s) => s.estatus == 'Abierto').length;

  double get montosTotales {
    var suma = 0.0;
    for (var servicio in servicios) {
      suma += servicio.montoProyecto;
    }
    return suma;
  }
}
