import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/columna.dart';
import '../modelos/datos_json.dart';
import '../utilidades/constantes.dart';
import '../utilidades/notificador_tabla_servicios.dart';

class TablaColumnas extends StatelessWidget {
  TablaColumnas();

  List<DataColumn> _crearEncabezados(List<Columna<Servicio>> columnas) =>
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
    return Consumer<NotificadorTablaServicios>(
      builder: (_, notificadorTabla, __) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            children: [
              PaginatedDataTable(
                key: UniqueKey(),
                columns: _crearEncabezados(notificadorTabla.columnasServicios),
                source: notificadorTabla.fuenteDatosServicios,
                sortColumnIndex: notificadorTabla.indiceColumnaOrdenada,
                sortAscending: notificadorTabla.ordenAscendente,
                rowsPerPage: notificadorTabla.renglonesPorPagina,
                availableRowsPerPage: [kRenglonesPorPagina, 10, 20],
                onRowsPerPageChanged: (renglones) =>
                    notificadorTabla.renglonesPorPagina = renglones!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
