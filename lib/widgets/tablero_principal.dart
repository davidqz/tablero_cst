import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/manejador_datos.dart';
import 'indicador_texto.dart';
import 'tabla_datos.dart';

class TableroPrincipal extends StatefulWidget {
  const TableroPrincipal();

  @override
  _TableroPrincipalState createState() => _TableroPrincipalState();
}

class _TableroPrincipalState extends State<TableroPrincipal> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ManejadorDatos>(
        builder: (_, datos, __) => Padding(
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
                            valor: '${datos.totalServicios}',
                          ),
                          IndicadorTexto(
                            titulo: 'Servicios Internos',
                            valor: '${datos.numServiciosInternos}',
                          ),
                          IndicadorTexto(
                            titulo: 'Servicios Abiertos',
                            valor: '${datos.numServiciosAbiertos}',
                          ),
                        ],
                      ),
                      Card(
                        child: SizedBox(
                          height: 150,
                          child: Center(
                            child: Text('Filtros',
                                style: Theme.of(context).textTheme.headline4),
                          ),
                        ),
                      ),
                      TablaDatos()
                    ],
                  ),
                ),
              ),
            ));
  }
}
