import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../modelos/columna.dart';
import '../modelos/datos_json.dart';
import 'constantes.dart';
import 'fuente_datos_tabla.dart';

class NotificadorTablaServicios extends ChangeNotifier {
  late FuenteDatosTabla<Servicio> fuenteDatosServicios;
  late List<Columna<Servicio>> columnasServicios;

  NotificadorTablaServicios() {
    columnasServicios = _generarColumnas();
    fuenteDatosServicios = FuenteDatosTabla(columnasServicios);
  }

  void actualizarServicios(List<Servicio> servicios) {
    fuenteDatosServicios.reemplazarDatos(servicios);
    final id = _indiceColumnaOrdenada;
    if (id != null) {
      columnasServicios[id].alOrdenar!(id, _ordenAscendente);
    }
    notifyListeners();
  }

  int _renglonesPorPagina = kRenglonesPorPagina;

  int get renglonesPorPagina => _renglonesPorPagina;

  set renglonesPorPagina(int renglones) {
    _renglonesPorPagina = renglones;
    notifyListeners();
  }

  int? _indiceColumnaOrdenada;

  int? get indiceColumnaOrdenada => _indiceColumnaOrdenada;

  set indiceColumnaOrdenada(int? indice) {
    _indiceColumnaOrdenada = indice;
    notifyListeners();
  }

  bool _ordenAscendente = false;

  bool get ordenAscendente => _ordenAscendente;

  set ordenAscendente(bool ascendete) {
    _ordenAscendente = ascendete;
    notifyListeners();
  }

  List<Columna<Servicio>> _generarColumnas() => [
        Columna<Servicio>(
            encabezado: 'ID',
            extraerTexto: (servicio) => servicio.idServicio.toString(),
            alOrdenar: (id, asc) {
              _sort<num>(id, asc, (servicio) => servicio.idServicio);
            }),
        Columna<Servicio>(
            encabezado: 'Nombre',
            extraerTexto: (servicio) => servicio.nombre,
            alOrdenar: (id, asc) {
              _sort<String>(id, asc, (servicio) => servicio.nombre);
            }),
        Columna<Servicio>(
            encabezado: 'Estatus',
            extraerTexto: (servicio) => servicio.estatus,
            alOrdenar: (id, asc) {
              _sort<String>(id, asc, (servicio) => servicio.estatus);
            }),
        Columna<Servicio>(
            encabezado: 'Sede',
            extraerTexto: (servicio) => servicio.sedeResponsable,
            alOrdenar: (id, asc) {
              _sort<String>(id, asc, (servicio) => servicio.sedeResponsable);
            }),
        Columna<Servicio>(
            encabezado: 'Cliente',
            extraerTexto: (servicio) => servicio.cliente.nombre,
            alOrdenar: (id, asc) {
              _sort<String>(id, asc, (servicio) => servicio.cliente.nombre);
            }),
        Columna<Servicio>(
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
        Columna<Servicio>(
            encabezado: 'Monto',
            extraerTexto: (servicio) =>
                kFormatoMoneda.format(servicio.finanzas.precioSinIVA),
            alineacionDerecha: true,
            alOrdenar: (id, asc) {
              _sort<num>(id, asc, (servicio) => servicio.finanzas.precioSinIVA);
            }),
        Columna<Servicio>(
            encabezado: 'Ingresos',
            extraerTexto: (servicio) =>
                kFormatoMoneda.format(servicio.sumaIngresos),
            alineacionDerecha: true,
            alOrdenar: (id, asc) {
              _sort<num>(id, asc, (servicio) => servicio.sumaIngresos);
            }),
        Columna<Servicio>(
            encabezado: 'Egresos',
            extraerTexto: (servicio) =>
                kFormatoMoneda.format(servicio.sumaEgresos),
            alineacionDerecha: true,
            alOrdenar: (id, asc) {
              _sort<num>(id, asc, (servicio) => servicio.sumaEgresos);
            }),
        Columna<Servicio>(
            encabezado: 'Último avance reportado',
            extraerTexto: (servicio) =>
                kFormatoPorcentaje.format(servicio.ultimoAvanceReportado),
            alineacionDerecha: true,
            alOrdenar: (id, asc) {
              _sort<num>(id, asc, (servicio) => servicio.ultimoAvanceReportado);
            })
      ];

  void _sort<T>(
    int id,
    bool asc,
    Comparable<T> Function(Servicio servicio) extraerCampo,
  ) {
    _indiceColumnaOrdenada = id;
    _ordenAscendente = asc;
    fuenteDatosServicios.sort<T>(ascendente: asc, extraerCampo: extraerCampo);
    notifyListeners();
  }
}
