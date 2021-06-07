import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import 'indicador_texto.dart';
import 'tabla_datos.dart';

class TableroPrincipal extends StatelessWidget {
  const TableroPrincipal();

  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
        builder: (_, almacen, __) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          IndicadorTexto(
                            titulo: 'Total servicios',
                            valor: '${almacen.totalServicios}',
                          ),
                          IndicadorTexto(
                            titulo: 'Servicios Internos',
                            valor: '${almacen.numServiciosInternos}',
                          ),
                          IndicadorTexto(
                            titulo: 'Servicios Abiertos',
                            valor: '${almacen.numServiciosAbiertos}',
                          ),
                        ],
                      ),
                      // Card(
                      //   child: SizedBox(
                      //     height: 150,
                      //     child: Center(
                      //       child: Text('Filtros',
                      //           style: Theme.of(context).textTheme.headline4),
                      //     ),
                      //   ),
                      // ),
                      TablaDatos(
                        titulo: 'Servicios',
                        encabezadosColumnas:
                            almacen.encabezadosColumnasTablaServicios,
                        datosRenglones: almacen.datosRenglones,
                        columnasNumericas: ['Monto'],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
