import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/columna_tabla.dart';
import '../modelos/datos_json.dart';
import '../utilidades/constantes.dart';
import '../utilidades/notificador_datos.dart';

class TablaDeColumnas extends StatelessWidget {
  TablaDeColumnas();

  List<DataColumn> _crearEncabezados(List<ColumnaTabla<Servicio>> columnas) =>
      columnas
          .map((columna) => DataColumn(
                label: Text(
                  columna.encabezado,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                numeric: columna.alineacionDerecha,
                onSort: columna.alOrdenar,
              ))
          .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    final datosTabla = context.watch<NotificadorDatos>();
    return Expanded(
      child: datosTabla.datosListos
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView(
                children: [
                  PaginatedDataTable(
                    key: UniqueKey(),
                    columns: _crearEncabezados(datosTabla.columnasServicios),
                    source: datosTabla.origenDatosTabla,
                    sortColumnIndex: datosTabla.indiceColumnaOrdenada,
                    sortAscending: datosTabla.ordenAscendente,
                    rowsPerPage: datosTabla.renglonesPorPagina,
                    availableRowsPerPage: [kRenglonesPorPagina, 10, 20],
                    onRowsPerPageChanged: (renglones) =>
                        datosTabla.renglonesPorPagina = renglones!,
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
