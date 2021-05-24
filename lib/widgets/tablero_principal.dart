import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modelos/modelo_datos.dart';

final formatCurrency = new NumberFormat.simpleCurrency();

class TableroPrincipal extends StatefulWidget {
  // Cambiar ModeloDatos por PaqueteDatos o AlmacenDatos
  final ModeloDatos _datos;

  TableroPrincipal(this._datos);

  @override
  _TableroPrincipalState createState() => _TableroPrincipalState();
}

class _TableroPrincipalState extends State<TableroPrincipal> {
  List<int> _anyos = [2019, 2020, 2021];
  int _anyoSeleccionado = 2021;
  List<int> _meses = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int _mesSeleccionado = 1;

  DateTime selectedDate = DateTime.now();

  int get totalServicios => widget._datos.servicios.length;

  List<Servicio> get serviciosInternos =>
      widget._datos.servicios.where((s) => s.interno == 1).toList();

  double _montosTotales(List<Servicio> servicios) {
    double suma = 0;
    for (var servicio in servicios) {
      suma += servicio.montoProyecto;
      // if (servicio.montoProyecto != 0)
      //   print('${servicio.idServicio}: monto=${servicio.montoProyecto}');
    }
    return suma;
  }

  double _ingresosTotales(List<Servicio> servicios) {
    double suma = 0;
    for (var servicio in servicios) {
      // double sumaServicio = 0;
      for (var ingreso in servicio.ingresos) {
        if (ingreso.anyo == _anyoSeleccionado &&
            ingreso.mes <= _mesSeleccionado) {
          // sumaServicio += ingreso.monto;
          suma += ingreso.monto;
        }
      }
      // if (sumaServicio != 0)
      //   print('${servicio.idServicio}: suma=${sumaServicio}');
    }
    return suma;
  }

  List<Servicio> get serviciosAbiertos =>
      widget._datos.servicios.where((s) => s.estatus == 'Abierto').toList();

  double _gastosTotales(List<Servicio> servicios) {
    double suma = 0;
    for (var servicio in servicios) {
      // double sumaServicio = 0;
      for (var ingreso in servicio.gastos) {
        if (ingreso.anyo == _anyoSeleccionado &&
            ingreso.mes <= _mesSeleccionado) {
          // sumaServicio += ingreso.monto;
          suma += ingreso.monto;
        }
      }
      // if (sumaServicio != 0)
      //   print('${servicio.idServicio}: suma=${sumaServicio}');
    }
    return suma;
  }

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
                      items: _anyos.map((anyo) {
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
                      items: _meses.map((mes) {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Montos: ${formatCurrency.format(_montosTotales(serviciosAbiertos))}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Ingresos: ${formatCurrency.format(_ingresosTotales(serviciosAbiertos))}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Gastos: ${formatCurrency.format(_gastosTotales(serviciosAbiertos))}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
