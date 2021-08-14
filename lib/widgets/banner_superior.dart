import 'package:flutter/material.dart';

import '../utilidades/constantes.dart';

class BannerSuperior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            image: AssetImage('imagenes/logo_conacyt.png'),
            height: 70,
          ),
        ),
        Column(
          children: [
            Text(
              kTituloPaginaWeb,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kColorSecundario),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            image: AssetImage('imagenes/logo_cimat.png'),
            height: 70,
          ),
        ),
      ],
    );
  }
}
