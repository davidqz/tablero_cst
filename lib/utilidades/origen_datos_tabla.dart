import 'package:flutter/material.dart';

import '../modelos/columna_tabla.dart';
import '../modelos/datos_json.dart';

class OrigenDatosTabla extends DataTableSource {
  List<Servicio> servicios;
  List<ColumnaTabla<Servicio>> columnas;

  OrigenDatosTabla(this.servicios, this.columnas);

  // void actualizarServicios(Iterable<Servicio> servicios) {
  //   _renglones = servicios
  //       .map((servicio) => _crearRenglones(
  //             textosCeldas: _convertirEnListaDeStrings(servicio: servicio),
  //           ))
  //       .toList(growable: false);
  //   notifyListeners();
  // }

  void sort<T>({
    required bool ascendente,
    required Comparable<T> Function(Servicio servicio) extraerCampo,
  }) {
    servicios.sort((a, b) {
      final campoA = extraerCampo(a);
      final campoB = extraerCampo(b);
      return ascendente
          ? Comparable.compare(campoA, campoB)
          : Comparable.compare(campoB, campoA);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int indice) {
    if (indice >= 0 && indice < servicios.length) {
      final celdas = columnas
          .map((columna) => DataCell(
              Text(columna.extraerTexto(servicios[indice]).toString())))
          .toList(growable: false);
      return DataRow.byIndex(index: indice, cells: celdas);
    }
    return null;
  }

  @override
  int get rowCount => servicios.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
