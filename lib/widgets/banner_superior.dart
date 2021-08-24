import 'package:flutter/material.dart';

import '../utilidades/constantes.dart';

class BannerSuperior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 80,
            child: Image(
              image: AssetImage('imagenes/logo_conacyt.png'),
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
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
          SizedBox(
            height: 80,
            child: Image(
              image: AssetImage('imagenes/logo_cimat.png'),
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      ),
    );
  }
}
