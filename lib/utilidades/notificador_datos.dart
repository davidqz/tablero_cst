import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../modelos/columna_tabla.dart';
import '../modelos/datos_json.dart';
import 'constantes.dart';
import 'origen_datos_tabla.dart';

class NotificadorDatos extends ChangeNotifier {
  late DatosJson _datos;
  late OrigenDatosTabla origenDatosTabla;
  final List<ColumnaTabla<Servicio>> columnasServicios = [];

  bool _datosListos = false;

  bool get datosListos => _datosListos;

  NotificadorDatos() {
    _cargarArchivoJson();
  }

  Future _cargarArchivoJson() async {
    print('Leyendo archivo: $kRutaDatosJson');
    final jsonString =
        await rootBundle.loadString(kRutaDatosJson, cache: false);
    final mapa = json.decode(jsonString) as Map<String, dynamic>;
    _datos = DatosJson.fromJson(mapa);
    _datosListos = true;
    print('${_datos.servicios.length} servicios correctamente leidos');
    _crearDatosTablaServicios();
    notifyListeners();
  }

  void _crearDatosTablaServicios() {
    origenDatosTabla = OrigenDatosTabla(_datos.servicios, columnasServicios);
    _generarColumnas();
  }

  int _renglonesPorPagina = kRenglonesPorPagina;

  int get renglonesPorPagina => _renglonesPorPagina;

  set renglonesPorPagina(int renglones) {
    _renglonesPorPagina = renglones;
    notifyListeners();
  }

  int _indiceColumnaOrdenada = 0;

  int get indiceColumnaOrdenada => _indiceColumnaOrdenada;

  set indiceColumnaOrdenada(int indice) {
    _indiceColumnaOrdenada = indice;
    notifyListeners();
  }

  bool _ordenAscendente = true;

  bool get ordenAscendente => _ordenAscendente;

  set ordenAscendente(bool ascendete) {
    _ordenAscendente = ascendete;
    notifyListeners();
  }

  List<Servicio> get servicios => _datos.servicios;

  void _generarColumnas() {
    columnasServicios.addAll([
      ColumnaTabla<Servicio>(
          encabezado: 'ID',
          extraerTexto: (servicio) => servicio.idServicio.toString(),
          alOrdenar: (id, asc) {
            _sort<num>(id, asc, (servicio) => servicio.idServicio);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Nombre',
          extraerTexto: (servicio) => servicio.nombre,
          alOrdenar: (id, asc) {
            _sort<String>(id, asc, (servicio) => servicio.nombre);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Estatus',
          extraerTexto: (servicio) => servicio.estatus,
          alOrdenar: (id, asc) {
            _sort<String>(id, asc, (servicio) => servicio.estatus);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Sede',
          extraerTexto: (servicio) => servicio.sedeResponsable,
          alOrdenar: (id, asc) {
            _sort<String>(id, asc, (servicio) => servicio.sedeResponsable);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Cliente',
          extraerTexto: (servicio) => servicio.cliente.nombre,
          alOrdenar: (id, asc) {
            _sort<String>(id, asc, (servicio) => servicio.cliente.nombre);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Fecha inicio',
          extraerTexto: (servicio) =>
              kFormatoFechaInterfaz.format(servicio.fechaInicio!),
          alOrdenar: (id, asc) {
            _sort<String>(
                id,
                asc,
                (servicio) =>
                    kFormatoFechaLectura.format(servicio.fechaInicio!));
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Monto',
          extraerTexto: (servicio) =>
              kFormatoMoneda.format(servicio.finanzas.precioSinIVA),
          alineacionDerecha: true,
          alOrdenar: (id, asc) {
            _sort<num>(id, asc, (servicio) => servicio.finanzas.precioSinIVA);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Total ingresos',
          extraerTexto: (servicio) =>
              kFormatoMoneda.format(servicio.finanzas.totalIngresos),
          alineacionDerecha: true,
          alOrdenar: (id, asc) {
            _sort<num>(id, asc, (servicio) => servicio.finanzas.totalIngresos);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Total egresos',
          extraerTexto: (servicio) =>
              kFormatoMoneda.format(servicio.finanzas.totalEgresos),
          alineacionDerecha: true,
          alOrdenar: (id, asc) {
            _sort<num>(id, asc, (servicio) => servicio.finanzas.totalEgresos);
          }),
      ColumnaTabla<Servicio>(
          encabezado: 'Último avance reportado',
          extraerTexto: (servicio) =>
              kFormatoPorcentaje.format(servicio.ultimoAvanceReportado),
          alineacionDerecha: true,
          alOrdenar: (id, asc) {
            _sort<num>(id, asc, (servicio) => servicio.ultimoAvanceReportado);
          }),
    ]);
  }

  void _sort<T>(
    int id,
    bool asc,
    Comparable<T> Function(Servicio servicio) extraerCampo,
  ) {
    _indiceColumnaOrdenada = id;
    _ordenAscendente = asc;
    origenDatosTabla.sort<T>(ascendente: asc, extraerCampo: extraerCampo);
    notifyListeners();
  }
}
