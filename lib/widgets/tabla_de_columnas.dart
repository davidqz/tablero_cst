import 'package:flutter/material.dart';

class TablaDeColumnas extends StatefulWidget {
  final String? titulo;
  final DataTableSource datosTabla;
  final List<DataColumn> encabezadosColumna;

  TablaDeColumnas({
    required Key key,
    this.titulo,
    required this.datosTabla,
    required this.encabezadosColumna,
  }) : super(key: key);

  @override
  _TablaDeColumnasState createState() => _TablaDeColumnasState();
}

class _TablaDeColumnasState extends State<TablaDeColumnas> {
  int _renglonesPorPagina = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    final optionalTitle = widget.titulo;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView(
        children: [
          PaginatedDataTable(
            key: widget.key,
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
            availableRowsPerPage: [5, 10, 15, 20, 50],
            columns: widget.encabezadosColumna,
            source: widget.datosTabla,
          )
        ],
      ),
    );
  }
}
