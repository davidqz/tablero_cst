import 'package:flutter/material.dart';

class TablaDatos extends StatefulWidget {
  final Iterable<String> etiquetasColumnas;
  final Iterable<Iterable<String>> datosRenglones;

  const TablaDatos({
    required this.etiquetasColumnas,
    required this.datosRenglones,
  });

  @override
  _TablaDatosState createState() => _TablaDatosState();
}

class _TablaDatosState extends State<TablaDatos> with RestorationMixin {
  final RestorableInt _rowsPerPage =
      RestorableInt(PaginatedDataTable.defaultRowsPerPage);

  @override
  String get restorationId => 'tabla_datos';

  @override
  void restoreState(_, __) {
    registerForRestoration(_rowsPerPage, 'rows_per_page');
  }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final columnas = widget.etiquetasColumnas
        .map((etiqueta) => DataColumn(
              label: Text(
                etiqueta,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              numeric: false,
            ))
        .toList(growable: false);

    return PaginatedDataTable(
      header: Text('Servicios'),
      rowsPerPage: _rowsPerPage.value,
      onRowsPerPageChanged: (value) {
        setState(() {
          _rowsPerPage.value = value!;
        });
      },
      availableRowsPerPage: [5, 10, 20, 50],
      columns: columnas,
      source: _OrigenTablaDatos(widget.datosRenglones),
    );
  }
}

class _OrigenTablaDatos extends DataTableSource {
  final Iterable<Iterable<String>> datosRenglones;
  late List<List<DataCell>> _renglones;

  _OrigenTablaDatos(this.datosRenglones) {
    _renglones = datosRenglones
        .map((datosRenglon) => datosRenglon
            .map((dato) => DataCell(Text(dato)))
            .toList(growable: false))
        .toList(growable: false);
  }

  @override
  DataRow getRow(int index) => DataRow.byIndex(
        index: index,
        cells: _renglones[index],
      );

  @override
  int get rowCount => datosRenglones.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
