import 'package:flutter/material.dart';

import '../utilidades/constantes.dart';

class BannerSuperior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: kAlturaBannerSuperior,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage('imagenes/logo_conacyt.png'),
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
            Text(
              kTituloPaginaWeb,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kColorSecundario),
            ),
            Image(
              image: AssetImage('imagenes/logo_cimat.png'),
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
          ],
        ),
      ),
    );
  }
}
