import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/manejador_datos.dart';

class TableroPrincipal extends StatefulWidget {
  const TableroPrincipal();

  @override
  _TableroPrincipalState createState() => _TableroPrincipalState();
}

class _TableroPrincipalState extends State<TableroPrincipal> {
  final List<int> anyos = [2019, 2020, 2021];
  int _anyoSeleccionado = 2021;
  final List<int> meses = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int _mesSeleccionado = 1;

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Año:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(width: 16),
                    DropdownButton<int>(
                      value: _anyoSeleccionado,
                      onChanged: (newValue) {
                        setState(() {
                          _anyoSeleccionado = newValue!;
                        });
                      },
                      items: anyos.map((anyo) {
                        return DropdownMenuItem(
                          child: Text(
                            '$anyo',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          value: anyo,
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 32),
                    Text(
                      'Mes:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(width: 16),
                    DropdownButton<int>(
                      value: _mesSeleccionado,
                      onChanged: (newValue) {
                        setState(() {
                          _mesSeleccionado = newValue!;
                        });
                      },
                      items: meses.map((mes) {
                        return DropdownMenuItem(
                          child: Text(
                            '$mes',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          value: mes,
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
              Consumer<ManejadorDatos>(
                builder: (_, manejador, __) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Total montos: ${manejador.montosTotales}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'Abiertos: ${manejador.numServiciosAbiertos}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
