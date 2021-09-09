import 'package:flutter/material.dart';

import '../modelos/columna.dart';

class FuenteDatosTabla<S> extends DataTableSource {
  final List<S> _datos = [];
  List<Columna<S>> columnas;

  FuenteDatosTabla(this.columnas);

  void reemplazarDatos(Iterable<S> nuevosDatos) {
    _datos.clear();
    _datos.addAll(nuevosDatos);
    notifyListeners();
  }

  void sort<T>({
    required bool ascendente,
    required Comparable<T> Function(S dato) extraerCampo,
  }) {
    _datos.sort((a, b) {
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
    if (indice >= 0 && indice < _datos.length) {
      final celdas = columnas
          .map(
              (columna) => DataCell(Text(columna.extraerTexto(_datos[indice]))))
          .toList(growable: false);
      return DataRow.byIndex(index: indice, cells: celdas);
    }
    return null;
  }

  @override
  int get rowCount => _datos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
