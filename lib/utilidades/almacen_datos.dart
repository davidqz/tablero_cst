import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'constantes.dart';
import 'datos_tabla_servicios.dart';
import 'modelo_datos_json.dart';

class AlmacenDatos extends ChangeNotifier {
  AlmacenDatos() {
    _cargarArchivoJson();
  }

  Future _cargarArchivoJson() async {
    print('Leyendo archivo: $kRutaDatosJson');
    final jsonString =
        await rootBundle.loadString(kRutaDatosJson, cache: false);
    final mapa = json.decode(jsonString) as Map<String, dynamic>;
    _datos = DatosJson.fromJson(mapa);
    _datosListos = true;
    datosTablaServicios = DatosTablaServicios(servicios: _datos.servicios);
    _calcularIndicadores();
  }

  void agregarFiltro(String nombre, bool seleccionado) {
    if (seleccionado) {
      _filtros.add(nombre);
    } else {
      _filtros.remove(nombre);
    }

    aplicarFiltros();
  }

  void aplicarFiltros() {
    _serviciosFiltrados =
        _datos.servicios.where((s) => _filtros.contains(s.sedeResponsable));
    datosTablaServicios.actualizarServicios(_serviciosFiltrados);
    _calcularIndicadores();
  }

  void reestablecerFiltros() {
    _filtros.clear();
    datosTablaServicios.actualizarServicios(_datos.servicios);
    _calcularIndicadores();
  }

  void _calcularIndicadores() {
    final servicios = _filtros.isEmpty ? _datos.servicios : _serviciosFiltrados;
    _numServicios = servicios.length;
    _numServiciosAbiertos = 0;
    _numServiciosInternos = 0;
    _sumaMontos = 0;
    _sumaIngresos = 0;
    _sumaEgresos = 0;
    for (var servicio in servicios) {
      _numServiciosAbiertos += servicio.estatus == 'Abierto' ? 1 : 0;
      _numServiciosInternos += servicio.esInterno ? 1 : 0;
      _sumaMontos += servicio.finanzas.precioSinIVA;
      _sumaIngresos += servicio.finanzas.totalIngresos;
      _sumaEgresos += servicio.finanzas.totalEgresos;
    }
    notifyListeners();
  }

  late DatosJson _datos;
  late DatosTablaServicios datosTablaServicios;

  bool _datosListos = false;

  bool get datosListos => _datosListos;

  final _filtros = [];
  Iterable<Servicio> _serviciosFiltrados = [];

  List<Moneda> get monedas => _datos.descriptores.monedas;

  List<ConceptoIngresoEgreso> get conceptos =>
      _datos.descriptores.conceptosIngresosEgresos;

  // -----------------------------------------------------------
  // ------------------ Indicadores ----------------------------
  // -----------------------------------------------------------

  int _numServicios = 0;

  int get numServicios => _numServicios;

  int _numServiciosAbiertos = 0;

  int get numServiciosAbiertos => _numServiciosAbiertos;

  int _numServiciosInternos = 0;

  int get numServiciosInternos => _numServiciosInternos;

  double _sumaMontos = 0.0;

  double get sumaMontos => _sumaMontos;

  double _sumaIngresos = 0.0;

  double get sumaIngresos => _sumaIngresos;

  double _sumaEgresos = 0.0;

  double get sumaEgresos => _sumaEgresos;
}
