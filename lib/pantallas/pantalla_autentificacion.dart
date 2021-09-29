import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tablero_cst/utilidades/autentificacion_usuario_basica.dart';

import '../utilidades/constantes.dart';
import '../widgets/banner_superior.dart';

class PantallaAutentificacion extends StatefulWidget {
  const PantallaAutentificacion({Key? key}) : super(key: key);

  @override
  _PantallaAutentificacionState createState() =>
      _PantallaAutentificacionState();
}

class _PantallaAutentificacionState extends State<PantallaAutentificacion> {
  final _controladorTextoUsuario = TextEditingController();
  final _controladorTextoContrasena = TextEditingController();

  void _autentficarUsuario() {
    final autentificacion = context.read<AutentificacionUsuarioBasica>();

    if (autentificacion.autentificarUsuario(
      nombre: _controladorTextoUsuario.text,
      contrasena: _controladorTextoContrasena.text,
    )) {
      Navigator.of(context).pushNamed(kRutaPrincipal);
    }
    _limpiarFormulario();
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
            const BannerSuperior(),
            const SizedBox(height: 50),
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
                            decoration: const InputDecoration(
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
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: const Text('Ingresar'),
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
