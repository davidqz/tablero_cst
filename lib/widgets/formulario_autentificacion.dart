import 'package:flutter/material.dart';

import '../utilidades/rutas.dart';

class FormularioAutentificacion extends StatefulWidget {
  FormularioAutentificacion();

  @override
  _FormularioAutentificacionState createState() =>
      _FormularioAutentificacionState();
}

class _FormularioAutentificacionState extends State<FormularioAutentificacion> {
  final _controladorTextoUsuario = TextEditingController();
  final _controladorTextoContrasena = TextEditingController();

  void _autentficarUsuario() {
    var usuario = _controladorTextoUsuario.text;
    var contrasena = _controladorTextoContrasena.text;
    _limpiarFormulario();

    // TODO: Implementar autentificacion
    if (usuario == 'admin' && contrasena == '1234') {
      print('Usuario: $usuario autentificado correctamente');
      Navigator.of(context).pushNamed(rutaPrincipal);
    } else {
      print('Usuario o contraseña invalidos');
    }
  }

  void _limpiarFormulario() {
    _controladorTextoUsuario.clear();
    _controladorTextoContrasena.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              controller: _controladorTextoUsuario,
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              onFieldSubmitted: (_) => _autentficarUsuario(),
              controller: _controladorTextoContrasena,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Ingresar'),
              onPressed: _autentficarUsuario,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controladorTextoUsuario.dispose();
    _controladorTextoContrasena.dispose();
    super.dispose();
  }
}
