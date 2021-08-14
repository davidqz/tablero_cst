import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

import 'modelo_datos_json.dart';

final _formatoMoneda = NumberFormat.simpleCurrency();
final _formatoPorcentaje = NumberFormat.percentPattern();

class DatosTablaServicios extends DataTableSource {
  // Para cada columna que se desee visualizar, incluir en el siguiente mapa un
  // elemento donde la llave sea el texto que se usara en el encabezado y el
  // valor sea un booleano para indicar si la columna es numerica y por lo
  // tanto el contenido de sus celdas se alinea hacia la derecha.
  final _mapeoEncabezadosColumnas = {
    'IDServicio': false,
    'Estatus': false,
    'EsInterno': false,
    'Nombre': false,
    'Sede Responsable': false,
    'Cliente': false,
    'Monto': true,
    'Ingresos totales': true,
    'Egresos totales': true,
    'Avance': true,
  };

  List<String> _convertirEnListaDeStrings({required Servicio servicio}) {
    return [
      servicio.idServicio.toString(),
      servicio.estatus,
      servicio.esInterno ? 'Interno' : 'Externo',
      servicio.nombreCorto,
      servicio.sedeResponsable,
      servicio.cliente.nombre,
      _formatoMoneda.format(servicio.finanzas.precioSinIVA),
      _formatoMoneda.format(servicio.finanzas.totalIngresos),
      _formatoMoneda.format(servicio.finanzas.totalEgresos),
      _formatoPorcentaje.format(servicio.ultimoAvanceReportado),
    ];
  }

  DatosTablaServicios({required final List<Servicio> servicios}) {
    actualizarServicios(servicios);
    _mapeoEncabezadosColumnas.forEach((texto, esNumerico) {
      encabezadosColumnas.add(DataColumn(
        label: Text(
          texto,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        numeric: esNumerico,
      ));
    });
  }

  void actualizarServicios(Iterable<Servicio> servicios) {
    _renglones = servicios
        .map((servicio) => _crearRenglones(
              textosCeldas: _convertirEnListaDeStrings(servicio: servicio),
            ))
        .toList(growable: false);
    notifyListeners();
  }

  List<DataCell> _crearRenglones({required final List<String> textosCeldas}) {
    return textosCeldas
        .map((textoCelda) => DataCell(Text(textoCelda)))
        .toList(growable: false);
  }

  final List<DataColumn> encabezadosColumnas = [];
  late List<List<DataCell>> _renglones;

  @override
  DataRow getRow(int index) => DataRow.byIndex(
      index: index, cells: _renglones[index], onSelectChanged: null);

  @override
  int get rowCount => _renglones.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
