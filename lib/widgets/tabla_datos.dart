import 'package:flutter/material.dart';

class TablaDatos extends StatefulWidget {
  TablaDatos();

  @override
  _TablaDatosState createState() => _TablaDatosState();
}

class _TablaDatosState extends State<TablaDatos> {
  final _columnas = const <DataColumn>[
    DataColumn(
      label: Text(
        'Clave',
        // style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    DataColumn(
      label: Text(
        'Nombre',
        // style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    DataColumn(
      label: Text(
        'Sede',
        // style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
  ];

  _ServiciosDataSource _serviciosDataSource = _ServiciosDataSource();

  @override
  void dispose() {
    _serviciosDataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: PaginatedDataTable(
          header: Text('Servicios'),
          rowsPerPage: 5,
          columns: _columnas,
          source: _serviciosDataSource,
        ),
      ),
    );
  }
}

class _ServiciosDataSource extends DataTableSource {
  _ServiciosDataSource();

  @override
  DataRow getRow(int index) {
    if (index == 0) {
      return DataRow.byIndex(index: 0, cells: [
        DataCell(Text('20410')),
        DataCell(Text('EME Bioestadística')),
        DataCell(Text('Aguascalientes')),
      ]);
    } elsegit {
      return DataRow.byIndex(index: 1, cells: [
        DataCell(Text('20411')),
        DataCell(Text('EMED 2020')),
        DataCell(Text('Aguascalientes')),
      ]);
    }
  }

  @override
  int get rowCount => 2;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
