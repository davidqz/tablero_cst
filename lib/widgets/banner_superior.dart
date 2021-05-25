import 'package:flutter/material.dart';

import '../utilidades/constantes.dart';

class BannerSuperior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            image: AssetImage('imagenes/logo_conacyt.png'),
            height: 96,
          ),
        ),
        Text(
          'Coordinación de Servicios Tecnológicos',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: kColorPrimario),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            image: AssetImage('imagenes/logo_cimat.png'),
            height: 96,
          ),
        ),
      ],
    );
  }
}
