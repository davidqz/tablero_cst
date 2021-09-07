import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../modelos/datos_json.dart';
import '../widgets/seccion_filtros.dart';
import 'constantes.dart';
import 'datos_tabla_servicios.dart';

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
    print('${_datos.servicios.length} servicios correctamente leidos');
    _pruebas([]);
    _calcularIndicadoresGlobales();
    _crearFiltros();
    //
    _datosListos = true;
    notifyListeners();
  }

  void _pruebas(List<Servicio> servicios) {
    if (servicios.isEmpty) {
      return;
    }
    final rango =
        DateTimeRange(start: DateTime(2021, 1, 1), end: DateTime(2021, 8, 30));
    final servicios2021 = servicios.where((servicio) {
      var ingresosEnRango = servicio.finanzas.ingresos.where((ingreso) =>
          ingreso.anyo >= rango.start.year && ingreso.anyo <= rango.end.year);
      return ingresosEnRango.isNotEmpty;
    });
    print('No. de servicios con ingresos en 2021: ${servicios2021.length}');
    for (var ser in servicios2021) {
      if (ser.sedeResponsable == 'Monterrey') {
        print('-${ser.idServicio}: ${ser.nombreCorto}, '
            '${ser.fechaInicio} + ${ser.estatus}');
        for (var ing in ser.finanzas.ingresos) {
          if (ing.montoSinIVA > 0 && ing.anyo == 2021) {
            print('  -${ing.anyo}, ${ing.mes}: ${ing.montoSinIVA}');
          }
        }
      }
    }
  }

  void _inicializarIndicadores() {
    _numServicios = 0;
    _sumaMontos = 0;
    _sumaIngresos = 0;
    _sumaEgresos = 0;
    _montosPorSede.clear();
    ingresosPorAnyo.clear();
    egresosPorAnyo.clear();
  }

  void _agregarServicioAIndicadores(Servicio servicio) {
    _numServicios++;
    _sumaMontos += servicio.finanzas.precioSinIVA;
    _sumaIngresos += servicio.finanzas.totalIngresos;
    _sumaEgresos += servicio.finanzas.totalEgresos;

    _montosPorSede.update(servicio.sedeResponsable,
        (monto) => monto + servicio.finanzas.precioSinIVA,
        ifAbsent: () => servicio.finanzas.precioSinIVA);

    for (var ingreso in servicio.finanzas.ingresos) {
      ingresosPorAnyo.update(
          ingreso.anyo.toString(), (monto) => monto + ingreso.montoSinIVA,
          ifAbsent: () => ingreso.montoSinIVA);
    }

    for (var egreso in servicio.finanzas.egresos) {
      egresosPorAnyo.update(
          egreso.anyo.toString(), (monto) => monto + egreso.montoSinIVA,
          ifAbsent: () => egreso.montoSinIVA);
    }
  }

  void _calcularIndicadoresGlobales() {
    _inicializarIndicadores();
    for (var servicio in _datos.servicios) {
      _agregarServicioAIndicadores(servicio);
    }
    datosTablaServicios.actualizarServicios(_datos.servicios);
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

  void rangoFechaSeleccionado(DateTimeRange? rangoFechas) {
    _rangoFechas = rangoFechas;
    _calcularIndicadoresAplicandoFiltros();
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
      // Primero filtramos por rango de fechas
      final rangoFechas = _rangoFechas;
      var serviciosEntreFechas;
      if (rangoFechas == null) {
        serviciosEntreFechas = _datos.servicios;
      } else {
        final rangoInicioMenosUnSegundo =
            rangoFechas.start.subtract(const Duration(seconds: 1));
        final rangoFinMasUnSegundo =
            rangoFechas.end.add(const Duration(seconds: 1));
        serviciosEntreFechas = _datos.servicios.where((servicio) {
          final fechaInicio = servicio.fechaInicio;
          return fechaInicio == null
              ? false
              : fechaInicio.isAfter(rangoInicioMenosUnSegundo) &&
                  fechaInicio.isBefore(rangoFinMasUnSegundo);
        });
      }

      // Despues filtramos por estatus de servicio
      final serviciosFiltradosPorEstatus = filtrosEstatusActivos.isEmpty
          ? serviciosEntreFechas
          : serviciosEntreFechas.where(
              (servicio) => filtrosEstatusActivos.contains(servicio.estatus));

      // Por ultimo filtramos por sede responable
      final serviciosFiltrados = <Servicio>[];
      _inicializarIndicadores();
      for (var servicio in serviciosFiltradosPorEstatus) {
        if (filtrosSedesActivos.isEmpty ||
            filtrosSedesActivos.contains(servicio.sedeResponsable)) {
          serviciosFiltrados.add(servicio);
          _agregarServicioAIndicadores(servicio);
        }
      }
      datosTablaServicios.actualizarServicios(serviciosFiltrados);
    }
    notifyListeners();
  }

  late DatosJson _datos;
  final datosTablaServicios = DatosTablaServicios();

  bool _datosListos = false;

  bool get datosListos => _datosListos;

  // Usamos SplayTreeSet para almacenar en orden alfabetico los diferentes
  // nombres de sedes y estatus entre todos los servicios leidos
  final _nombresSedes = SplayTreeSet<String>();
  final _nombresEstatus = SplayTreeSet<String>();

  final _filtrosSedes = <Filtro>[];
  final _filtrosEstatus = <Filtro>[];

  List<Filtro> get filtrosSedes => _filtrosSedes;

  List<Filtro> get filtrosEstatus => _filtrosEstatus;

  DateTimeRange? _rangoFechas;

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
