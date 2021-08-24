import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilidades/almacen_datos.dart';
import '../utilidades/filtros.dart';
import 'seleccionador_rango_fecha.dart';
import 'tarjeta_con_titulo.dart';

class SeccionFiltros extends StatefulWidget {
  SeccionFiltros();

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
    return Row(
      children: [
        TarjetaConTitulo(
          flex: 1,
          titulo: 'Filtro por estatus',
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Wrap(
              children: _construirFilterChips(
                  Provider.of<AlmacenDatos>(context, listen: false)
                      .filtrosEstatus),
            ),
          ),
        ),
        TarjetaConTitulo(
          flex: 2,
          titulo: 'Filtro por sede',
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Wrap(
              children: _construirFilterChips(
                  Provider.of<AlmacenDatos>(context, listen: false)
                      .filtrosSedes),
            ),
          ),
        ),
        TarjetaConTitulo(
          flex: 2,
          titulo: 'Filtro por periodo',
          child: SeleccionadorRangoFecha(
              alDefinirRangoFecha:
                  Provider.of<AlmacenDatos>(context, listen: false)
                      .rangoFechaSeleccionado),
        ),
      ],
    );
  }
}
