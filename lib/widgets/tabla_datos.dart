import 'package:flutter/material.dart';

// Widget que implementa una tabla de datos paginada (PaginatedDataTable) dados
// una lista de encabezados de columna y una lista de renglones, donde cada
// renglon es una lista de los valores (String) de cada celda.
// El titulo opcional, si se provee, se despliega justo antes de la tabla
// orientado a la izquierda.
// La lista opcional columnasNumericas, indica cuales encabezados de columna
// son numericos para alinearlos del lado derecho de la columna.
class TablaDatos extends StatefulWidget {
  final String? titulo;
  final Iterable<String> encabezadosColumnas;
  final Iterable<Iterable<String>> datosRenglones;
  final Iterable<String>? columnasNumericas;

  TablaDatos({
    this.titulo,
    required this.encabezadosColumnas,
    required this.datosRenglones,
    this.columnasNumericas,
  }) : assert(
            encabezadosColumnas.isNotEmpty &&
                datosRenglones.isNotEmpty &&
                encabezadosColumnas.length == datosRenglones.first.length,
            'etiquetasColumnas debe tener el mismo numero '
            'de elementos que datosRenglones.first');

  @override
  _TablaDatosState createState() => _TablaDatosState();
}

class _TablaDatosState extends State<TablaDatos> {
  int _renglonesPorPagina = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    final columnas = widget.encabezadosColumnas
        .map((encabezado) => DataColumn(
              label: Text(
                encabezado,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              numeric: widget.columnasNumericas?.contains(encabezado) ?? false,
            ))
        .toList(growable: false);
    final optionalTitle = widget.titulo;
    return PaginatedDataTable(
      header: optionalTitle != null
          ? Text(
              optionalTitle,
              style: Theme.of(context).textTheme.headline4,
            )
          : null,
      rowsPerPage: _renglonesPorPagina,
      onRowsPerPageChanged: (value) {
        setState(() {
          _renglonesPorPagina = value!;
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
