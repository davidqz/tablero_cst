import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pantallas/pantalla_autentificacion.dart';
import '../utilidades/autentificacion_usuario_basica.dart';

class VerificadorUsuario extends StatelessWidget {
  final Widget pantalla;

  const VerificadorUsuario(this.pantalla, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context
        .read<AutentificacionUsuarioBasica>()
        .auntentificadoCorrectamente) {
      return pantalla;
    }
    return const PantallaAutentificacion();
  }
}
