import 'package:flutter/material.dart';

class SeleccionadorFecha extends StatefulWidget {
  // final format = DateFormat("dd/MMM/yy");
  // DateTime _selectedDate = DateTime.now();

  @override
  _SeleccionadorFechaState createState() => _SeleccionadorFechaState();
}

class _SeleccionadorFechaState extends State<SeleccionadorFecha> {
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputController.addListener(_onEdit);
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void _onEdit() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          child: Text('Seleccionar periodo'),
          onPressed: () {
            showDateRangePicker(
              context: context,
              firstDate: DateTime(2016),
              lastDate: DateTime.now(),
              initialEntryMode: DatePickerEntryMode.input,
            );
          }),
    );
  }
}
