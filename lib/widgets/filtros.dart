import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';

class Filtros extends StatefulWidget {
  Filtros();

  @override
  _FiltrosState createState() => _FiltrosState();
}

class _FiltrosState extends State<Filtros> {
  final List<String> _nombres = ['Guanajuato', 'Zacatecas', 'Monterrey'];
  List<bool> _activado = [false, false, false];

  List<FilterChip> crearChips(AlmacenDatos almacen) {
    var chips = <FilterChip>[];
    for (var k = 0; k < _nombres.length; k++) {
      chips.add(
        FilterChip(
          label: Text(_nombres[k]),
          selected: _activado[k],
          onSelected: (selected) {
            setState(() {
              _activado[k] = selected;
            });
            almacen.agregarFiltro(_nombres[k], selected);
          },
        ),
      );
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
      builder: (_, almacen, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtros',
              style: Theme.of(context).textTheme.headline5,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: crearChips(almacen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
