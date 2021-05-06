import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tablero_cst/utilidades/constantes.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image(
                  image: AssetImage('lib/imagenes/logo_conacyt.png'),
                  height: 80,
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
                padding: const EdgeInsets.all(24.0),
                child: Image(
                  image: AssetImage('lib/imagenes/logo_cimat.png'),
                  height: 80,
                ),
              ),
            ],
          ),
          Center(
            child: IconButton(
              icon: Icon(FontAwesome.repeat),
              onPressed: () {
                print('Reload');
              },
            ),
          )
        ],
      ),
    );
  }
}
