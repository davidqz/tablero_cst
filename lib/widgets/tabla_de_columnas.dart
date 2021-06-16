import 'package:flutter/material.dart';

class TablaDeColumnas extends StatefulWidget {
  final String? titulo;
  final DataTableSource datosTabla;
  final List<DataColumn> encabezadosColumna;

  TablaDeColumnas({
    this.titulo,
    required this.datosTabla,
    required this.encabezadosColumna,
  });

  @override
  _TablaDeColumnasState createState() => _TablaDeColumnasState();
}

class _TablaDeColumnasState extends State<TablaDeColumnas> {
  int _renglonesPorPagina = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
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
      columns: widget.encabezadosColumna,
      source: widget.datosTabla,
    );
  }
}
