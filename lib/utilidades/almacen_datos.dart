import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../modelos/datos_json.dart';
import '../widgets/seccion_filtros.dart';
import 'constantes.dart';

class AlmacenDatos extends ChangeNotifier {
  late DatosJson _datos;

  AlmacenDatos() {
    _cargarArchivoJson().then((_) {
      _calcularIndicadoresGlobales();
      _crearFiltros();
      notifyListeners();
    });
  }

  Future _cargarArchivoJson() async {
    print('Leyendo archivo: $kArchivoDatosJson');
    final jsonString =
        await rootBundle.loadString(kArchivoDatosJson, cache: false);
    final mapa = json.decode(jsonString) as Map<String, dynamic>;
    _datos = DatosJson.fromJson(mapa);
    _datosListos = true;
    print('${_datos.servicios.length} servicios correctamente leidos');
  }

  void _calcularIndicadoresGlobales() {
    _inicializarIndicadores();
    for (var servicio in _datos.servicios) {
      _agregarServicioAIndicadores(servicio);
    }
  }

  void _crearFiltros() {
    for (var servicio in _datos.servicios) {
      _nombresSedes.add(servicio.sedeResponsable);
      _nombresEstatus.add(servicio.estatus);
    }
    // Filtros de Sede
    for (var nombreSede in _nombresSedes) {
      _filtrosSedes.add(
        Filtro(
          nombre: nombreSede,
          alSeleccionarlo: _calcularIndicadoresAplicandoFiltros,
        ),
      );
    }

    // Filtros de Estatus
    for (var nombreEstatus in _nombresEstatus) {
      _filtrosEstatus.add(
        Filtro(
          nombre: nombreEstatus,
          alSeleccionarlo: _calcularIndicadoresAplicandoFiltros,
        ),
      );
    }
  }

  void _inicializarIndicadores() {
    _numServicios = 0;
    _sumaMontos = 0;
    _sumaIngresos = 0;
    _sumaEgresos = 0;
    _montosPorSede.clear();
    _ingresosPorAnyo.clear();
    _egresosPorAnyo.clear();
  }

  void _agregarServicioAIndicadores(Servicio servicio) {
    _numServicios++;
    _sumaMontos += servicio.finanzas.precioSinIVA;
    _sumaIngresos += servicio.sumaIngresos;
    _sumaEgresos += servicio.sumaEgresos;

    _montosPorSede.update(servicio.sedeResponsable,
        (monto) => monto + servicio.finanzas.precioSinIVA,
        ifAbsent: () => servicio.finanzas.precioSinIVA);

    for (var ingreso in servicio.ingresos) {
      _ingresosPorAnyo.update(
          ingreso.anyo.toString(), (monto) => monto + ingreso.montoSinIVA,
          ifAbsent: () => ingreso.montoSinIVA);
    }

    for (var egreso in servicio.egresos) {
      _egresosPorAnyo.update(
          egreso.anyo.toString(), (monto) => monto + egreso.montoSinIVA,
          ifAbsent: () => egreso.montoSinIVA);
    }
  }

  void _calcularIndicadoresAplicandoFiltros() {
    final filtrosSedesActivos = _filtrosSedes
        .where((filtro) => filtro.seleccionado)
        .map((filtro) => filtro.nombre);
    final filtrosEstatusActivos = _filtrosEstatus
        .where((filtro) => filtro.seleccionado)
        .map((filtro) => filtro.nombre);

    // Si no hay ningun filtro activo, utilizamos todos los servicios
    if (filtrosSedesActivos.isEmpty &&
        filtrosEstatusActivos.isEmpty &&
        _rangoFechas == null) {
      _calcularIndicadoresGlobales();
    } else {
      // Primero filtramos por periodo
      List<Servicio> serviciosEntreFechas;
      if (_rangoFechas == null) {
        serviciosEntreFechas = _datos.servicios;
      } else {
        serviciosEntreFechas = _datos.servicios
            .where((servicio) =>
                servicio.sumaIngresos > 0 || servicio.sumaEgresos > 0)
            .toList();
      }

      // Despues filtramos por estatus de servicio
      final serviciosFiltradosPorEstatus = filtrosEstatusActivos.isEmpty
          ? serviciosEntreFechas
          : serviciosEntreFechas.where(
              (servicio) => filtrosEstatusActivos.contains(servicio.estatus));

      // Por ultimo filtramos por sede responable
      _serviciosFiltrados.clear();
      _inicializarIndicadores();
      for (var servicio in serviciosFiltradosPorEstatus) {
        if (filtrosSedesActivos.isEmpty ||
            filtrosSedesActivos.contains(servicio.sedeResponsable)) {
          _serviciosFiltrados.add(servicio);
          _agregarServicioAIndicadores(servicio);
        }
      }
    }
    notifyListeners();
  }

  bool _datosListos = false;

  bool get datosListos => _datosListos;

  final List<Servicio> _serviciosFiltrados = [];

  List<Servicio> get servicios =>
      _hayFiltrosActivos ? _serviciosFiltrados : _datos.servicios;

  bool get _hayFiltrosActivos {
    if (_filtrosSedes.any((filtro) => filtro.seleccionado)) {
      return true;
    }
    if (_filtrosEstatus.any((filtro) => filtro.seleccionado)) {
      return true;
    }
    if (_rangoFechas != null) {
      return true;
    }
    return false;
  }

  // Usamos SplayTreeSet para almacenar en orden alfabetico los diferentes
  // nombres de sedes y estatus entre todos los servicios leidos
  final _nombresSedes = SplayTreeSet<String>();
  final _nombresEstatus = SplayTreeSet<String>();

  final _filtrosSedes = <Filtro>[];
  final _filtrosEstatus = <Filtro>[];

  List<Filtro> get filtrosSedes => _filtrosSedes;

  List<Filtro> get filtrosEstatus => _filtrosEstatus;

  DateTimeRange? _rangoFechas;

  void rangoFechaSeleccionado(DateTimeRange? rangoFechas) {
    _rangoFechas = rangoFechas;
    for (var servicio in _datos.servicios) {
      servicio.rangoFecha = rangoFechas;
    }
    _calcularIndicadoresAplicandoFiltros();
  }

  // -----------------------------------------------------------
  // ------------------ Indicadores ----------------------------
  // -----------------------------------------------------------

  int _numServicios = 0;

  int get numServicios => _numServicios;

  double _sumaMontos = 0.0;

  double get sumaMontos => _sumaMontos;

  double _sumaIngresos = 0.0;

  double get sumaIngresos => _sumaIngresos;

  double _sumaEgresos = 0.0;

  double get sumaEgresos => _sumaEgresos;

  // Usamos SplayTreeMap para mantener el orden de las sedes y los años
  final _montosPorSede = SplayTreeMap<String, double>();

  SplayTreeMap<String, double> get montosPorSede => _montosPorSede;

  final _ingresosPorAnyo = SplayTreeMap<String, double>();

  SplayTreeMap<String, double> get ingresosPorAnyo => _ingresosPorAnyo;

  final _egresosPorAnyo = SplayTreeMap<String, double>();

  SplayTreeMap<String, double> get egresosPorAnyo => _egresosPorAnyo;
}
