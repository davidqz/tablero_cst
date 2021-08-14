import 'package:flutter/material.dart';

import '../widgets/banner_superior.dart';
import '../widgets/formulario_autentificacion.dart';

class PantallaAutentificacion extends StatelessWidget {
  const PantallaAutentificacion();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          BannerSuperior(),
          SizedBox(height: 50),
          SizedBox(
            width: 400,
            child: Card(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: FormularioAutentificacion(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
