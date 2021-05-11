import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../datos/modelo/modelo_datos.dart';
import '../utilidades/constantes.dart';

class PantallaInicio extends StatelessWidget {
  Future<ModeloDatos> cargarDatos() async {
    print("Cargar Datos");
    // Leer archivo
    final jsonString = await rootBundle.loadString("lib/datos/datos_sgp1.json");
    print(jsonString.length);

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
          Column(
            children: [
              Center(
                child: FutureBuilder<ModeloDatos>(
                  future: cargarDatos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return snapshot.hasData
                        ? TableroPrincipal(datos: snapshot.data!)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              IconButton(
                icon: Icon(FontAwesome.repeat),
                onPressed: () {
                  print('Reload');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TableroPrincipal extends StatefulWidget {
  TableroPrincipal({required this.datos});

  final ModeloDatos datos;

  @override
  _TableroPrincipalState createState() => _TableroPrincipalState();
}

class _TableroPrincipalState extends State<TableroPrincipal> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No de servicios: ${widget.datos.servicios.length}'),
    );
  }
}
