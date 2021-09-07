import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/usuario.dart';
import '../utilidades/constantes.dart';
import '../widgets/banner_superior.dart';

class PantallaAutentificacion extends StatefulWidget {
  const PantallaAutentificacion();

  @override
  _PantallaAutentificacionState createState() =>
      _PantallaAutentificacionState();
}

class _PantallaAutentificacionState extends State<PantallaAutentificacion> {
  final _controladorTextoUsuario = TextEditingController();
  final _controladorTextoContrasena = TextEditingController();

  void _autentficarUsuario() {
    var usuario = _controladorTextoUsuario.text;
    var contrasena = _controladorTextoContrasena.text;
    _limpiarFormulario();

    // TODO: Implementar autentificacion
    if (usuario == 'admin' && contrasena == '1234') {
      context.read<Usuario>().autentificacionExitosa(usuario);
      Navigator.of(context).pushNamed(kRutaPrincipal);
    } else {
      print('Usuario o contraseña invalidos');
    }
  }

  void _limpiarFormulario() {
    _controladorTextoUsuario.clear();
    _controladorTextoContrasena.clear();
  }

  @override
  void dispose() {
    _controladorTextoUsuario.dispose();
    _controladorTextoContrasena.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BannerSuperior(),
            SizedBox(height: 50),
            SizedBox(
              width: 400,
              child: Card(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.all(8.0),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
