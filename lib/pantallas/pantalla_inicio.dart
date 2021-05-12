import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../modelo_datos/modelo_datos.dart';
import '../utilidades/constantes.dart';

class PantallaInicio extends StatelessWidget {
  Future<ModeloDatos> cargarDatos() async {
    // Leer archivo
    final jsonString = await rootBundle
        .loadString("assets/datos/datos_sgp_desarrollo_v1.json", cache: false);

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(procesarDatos, jsonString);
  }

  ModeloDatos procesarDatos(String jsonString) {
    final datos = json.decode(jsonString) as Map<String, dynamic>;
    return ModeloDatos.fromJson(datos);
  }

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
                  image: AssetImage('assets/imagenes/logo_conacyt.png'),
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
                  image: AssetImage('assets/imagenes/logo_cimat.png'),
                  height: 80,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Center(
                child: FutureBuilder<ModeloDatos>(
                  future: cargarDatos(),
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
        ],
      ),
    );
  }
}

class TableroPrincipal extends StatelessWidget {
  TableroPrincipal(this._datos);

  final ModeloDatos _datos;

  int get totalServicios => _datos.servicios.length;

  List<Servicio> get serviciosAbiertos =>
      _datos.servicios.where((s) => s.estatus == 'Abierto').toList();

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'No de servicios: $totalServicios',
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'Abiertos: ${serviciosAbiertos.length}',
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'Cerrados: ${totalServicios - serviciosAbiertos.length}',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
