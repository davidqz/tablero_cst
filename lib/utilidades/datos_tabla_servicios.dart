import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

import 'modelo_datos_json.dart';

final _formatoMoneda = NumberFormat.simpleCurrency();
final _formatoPorcentaje = NumberFormat.percentPattern();

class DatosTablaServicios extends DataTableSource {
  final List<DataColumn> _encabezadosColumnas = [];
  late List<List<DataCell>> _renglones;

  // Para cada columna que se desee visualizar, incluir en el siguiente mapa un
  // elemento donde la llave sea el texto que se usara en el encabezado y el
  // valor sea un booleano para indicar su la columna es numerica y por lo
  // tanto el contenido de sus celdas se alineara hacia la derecha.
  final _mapeoEncabezadosColumnas = {
    'IDServicio': false,
    'Estatus': false,
    'Nombre': false,
    'Sede Responsable': false,
    'Area de Vinculación': false,
    'Zona de influencia': false,
    'Cliente': false,
    'Monto': true, // Valor numerico (moneda)
    'Ingresos totales': true,
    'Egresos totales': true,
    'Avance': true,
  };

  List<String> _convertirEnListaDeStrings({required Servicio servicio}) {
    return [
      servicio.idServicio.toString(),
      servicio.estatus,
      servicio.nombreCorto,
      servicio.sedeResponsable,
      servicio.areaVinculacionResponsable,
      servicio.zonaInfluencia,
      servicio.cliente.nombre,
      _formatoMoneda.format(servicio.finanzas.precioSinIVA),
      _formatoMoneda.format(servicio.finanzas.totalIngresos),
      _formatoMoneda.format(servicio.finanzas.totalIngresos),
      _formatoPorcentaje.format(servicio.ultimoAvanceReportado),
    ];
  }

  List<DataCell> _crearRenglones({required final List<String> textosCeldas}) {
    return textosCeldas
        .map((textoCelda) => DataCell(Text(textoCelda)))
        .toList(growable: false);
  }

  DatosTablaServicios({required final List<Servicio> servicios}) {
    _renglones = servicios.map((servicio) {
      return _crearRenglones(
        textosCeldas: _convertirEnListaDeStrings(servicio: servicio),
      );
    }).toList(growable: false);

    _mapeoEncabezadosColumnas.forEach((texto, esNumerico) {
      _encabezadosColumnas.add(DataColumn(
        label: Text(
          texto,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        numeric: esNumerico,
      ));
    });
  }

  List<DataColumn> get encabezadosColumnas => _encabezadosColumnas;

  @override
  DataRow getRow(int index) => DataRow.byIndex(
        index: index,
        cells: _renglones[index],
      );

  @override
  int get rowCount => _renglones.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
