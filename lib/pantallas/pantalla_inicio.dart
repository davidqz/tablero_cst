import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:tablero_cst/widgets/banner_superior.dart';
import 'package:tablero_cst/widgets/tablero_principal.dart';

import '../modelos/modelo_datos.dart';
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
          BannerSuperior(),
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
