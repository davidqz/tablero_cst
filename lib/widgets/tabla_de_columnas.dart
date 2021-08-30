import 'package:flutter/material.dart';

import '../utilidades/constantes.dart';

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
  int _renglonesPorPagina = kRenglonesPorPagina;

  @override
  Widget build(BuildContext context) {
    final optionalTitle = widget.titulo;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          children: [
            PaginatedDataTable(
              key: UniqueKey(),
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
              availableRowsPerPage: [kRenglonesPorPagina, 10, 20],
              columns: widget.encabezadosColumna,
              source: widget.datosTabla,
            ),
          ],
        ),
      ),
    );
  }
}
