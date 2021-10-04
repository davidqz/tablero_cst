import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pantallas/pantalla_autentificacion.dart';
import '../pantallas/pantalla_principal.dart';
import '../utilidades/autentificacion_usuario_basica.dart';

class VerificadorUsuario extends StatelessWidget {
  const VerificadorUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context
        .read<AutentificacionUsuarioBasica>()
        .auntentificadoCorrectamente) {
      return const PantallaPrincipal();
    }
    return const PantallaAutentificacion();
  }
}
