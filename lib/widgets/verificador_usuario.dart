import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/usuario.dart';
import '../pantallas/pantalla_autentificacion.dart';
import '../pantallas/pantalla_principal.dart';

class VerificadorUsuario extends StatelessWidget {
  const VerificadorUsuario();

  @override
  Widget build(BuildContext context) {
    if (context.read<Usuario>().auntentificado) {
      return PantallaPrincipal();
    }
    return PantallaAutentificacion();
  }
}
