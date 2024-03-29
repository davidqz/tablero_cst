import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import 'seleccionador_rango_fecha.dart';
import 'tarjeta_con_titulo.dart';

class Filtro {
  final String nombre;
  final Function alSeleccionarlo;
  bool seleccionado = false;

  Filtro({
    required this.nombre,
    required this.alSeleccionarlo,
  });
}

class SeccionFiltros extends StatefulWidget {
  const SeccionFiltros({Key? key}) : super(key: key);

  @override
  _SeccionFiltrosState createState() => _SeccionFiltrosState();
}

class _SeccionFiltrosState extends State<SeccionFiltros> {
  List<FilterChip> _construirFilterChips(List<Filtro> filtros) {
    return filtros
        .map((filtro) => FilterChip(
              label: Text(filtro.nombre),
              labelPadding: const EdgeInsets.all(4.0),
              selected: filtro.seleccionado,
              onSelected: (sleccionado) {
                // Cambia el estado de la interfaz (UI)
                setState(() {
                  filtro.seleccionado = sleccionado;
                });
                filtro.alSeleccionarlo();
              },
            ))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlmacenDatos>(
      builder: (_, almacen, __) => Row(
        children: [
          TarjetaConTitulo(
            titulo: 'Filtro por estatus',
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Wrap(
                children: _construirFilterChips(almacen.filtrosEstatus),
              ),
            ),
          ),
          TarjetaConTitulo(
            titulo: 'Filtro por sede',
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Wrap(
                children: _construirFilterChips(almacen.filtrosSedes),
              ),
            ),
          ),
          TarjetaConTitulo(
            seExpande: false,
            titulo: 'Filtro por periodo',
            widget: SeleccionadorRangoFecha(
                alDefinirRangoFecha: almacen.rangoFechaSeleccionado),
          ),
        ],
      ),
    );
  }
}
