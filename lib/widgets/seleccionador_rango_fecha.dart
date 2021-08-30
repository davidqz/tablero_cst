import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilidades/constantes.dart';

class SeleccionadorRangoFecha extends StatefulWidget {
  final Function(DateTimeRange?) alDefinirRangoFecha;

  SeleccionadorRangoFecha({required this.alDefinirRangoFecha});

  @override
  _SeleccionadorRangoFechaState createState() =>
      _SeleccionadorRangoFechaState();
}

class _SeleccionadorRangoFechaState extends State<SeleccionadorRangoFecha> {
  late TextEditingController _controladorFechaInicio;
  late TextEditingController _controladorFechaFin;
  late FocusNode _nodoEnfoqueFechaInicio;
  late FocusNode _nodoEnfoqueFechaFin;

  @override
  void initState() {
    super.initState();
    _controladorFechaInicio = TextEditingController();
    _controladorFechaFin = TextEditingController();
    _nodoEnfoqueFechaInicio = FocusNode();
    _nodoEnfoqueFechaFin = FocusNode();
  }

  DateTimeRange? _obtenerRangoDeFechasValidas() {
    // Tratamos de obtener fechas validas de los TextFields. Si ambas
    // fechas (inicio y fin) son validas, las usamos como initialDateRange
    // del dialogo que permite seleccionar un rango de fechas.
    DateTime? fechaInicio;
    DateTime? fechaFin;
    if (_controladorFechaInicio.text.isNotEmpty &&
        _controladorFechaFin.text.isNotEmpty) {
      try {
        fechaInicio =
            kFormatoFechaInterfaz.parseLoose(_controladorFechaInicio.text);
        fechaFin = kFormatoFechaInterfaz.parseLoose(_controladorFechaFin.text);
      } on Exception catch (e) {
        print(e.toString());
      }
      if (fechaInicio != null && fechaFin != null) {
        if (fechaInicio.isAfter(fechaFin)) {
          print('Fecha inicio debe ser antes de fechaFin');
        } else {
          return DateTimeRange(start: fechaInicio, end: fechaFin);
        }
      }
    }
    return null;
  }

  void _mostrarSeleccionadorRangoFecha() async {
    final rangoFechaElegido = await showDateRangePicker(
        context: context,
        initialDateRange: _obtenerRangoDeFechasValidas(),
        firstDate: DateTime(2016),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Center(
            child: SizedBox(
              width: 400.0,
              height: 500.0,
              child: child,
            ),
          );
        });

    if (rangoFechaElegido != null) {
      setState(() {
        _controladorFechaInicio.value = TextEditingValue(
          text: kFormatoFechaInterfaz.format(rangoFechaElegido.start),
        );
        _controladorFechaFin.value = TextEditingValue(
          text: kFormatoFechaInterfaz.format(rangoFechaElegido.end),
        );
      });
      widget.alDefinirRangoFecha(rangoFechaElegido);
    }
  }

  void _fechaCambiada(_) {
    widget.alDefinirRangoFecha(_obtenerRangoDeFechasValidas());
  }

  void _borrarFechas() {
    setState(() {
      _controladorFechaInicio.clear();
      _controladorFechaFin.clear();
      _nodoEnfoqueFechaInicio.unfocus();
      _nodoEnfoqueFechaFin.unfocus();
    });
    widget.alDefinirRangoFecha(null);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        IconButton(
          splashRadius: 24.0,
          onPressed: _mostrarSeleccionadorRangoFecha,
          icon: Icon(Icons.date_range_rounded),
          visualDensity: VisualDensity.compact,
        ),
        SizedBox(width: 4.0),
        SizedBox(
          width: 110,
          child: TextField(
            controller: _controladorFechaInicio,
            focusNode: _nodoEnfoqueFechaInicio,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText: 'Fecha inicio'),
            onSubmitted: _fechaCambiada,
          ),
        ),
        SizedBox(width: 4.0),
        SizedBox(
          width: 110,
          child: TextField(
            focusNode: _nodoEnfoqueFechaFin,
            controller: _controladorFechaFin,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText: 'Fecha fin'),
            onSubmitted: _fechaCambiada,
          ),
        ),
        SizedBox(width: 4.0),
        IconButton(
          splashRadius: 24.0,
          onPressed: _borrarFechas,
          icon: Icon(Icons.clear_rounded),
          visualDensity: VisualDensity.compact,
        )
      ],
    );
  }

  @override
  void dispose() {
    _controladorFechaInicio.dispose();
    _controladorFechaFin.dispose();
    _nodoEnfoqueFechaFin.dispose();
    _nodoEnfoqueFechaInicio.dispose();
    super.dispose();
  }
}
