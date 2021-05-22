import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:tablero_cst/widgets/tablero_principal.dart';

import '../modelo_datos/modelo_datos.dart';
import '../utilidades/constantes.dart';

class PantallaInicio extends StatelessWidget {
  Future<ModeloDatos> _cargarDatos(BuildContext context) async {
    print('Leyendo archivo: $kRutaDatosJson');
    final jsonString =
        await DefaultAssetBundle.of(context).loadString(kRutaDatosJson);
    return compute(_procesarDatos, jsonString);
  }

  ModeloDatos _procesarDatos(String jsonString) {
    final mapa = json.decode(jsonString) as Map<String, dynamic>;
    return ModeloDatos.fromJson(mapa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          // Banner superior con logos y titulo
          Row(
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
          ),
          Expanded(
            child: FutureBuilder<ModeloDatos>(
              future: _cargarDatos(context),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? TableroPrincipal(snapshot.data!)
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
