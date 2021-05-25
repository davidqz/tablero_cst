import 'package:flutter/material.dart';

// Color del logo de CIMAT de acuerdo al manual:
// https://www.cimat.mx/sites/default/files/Intranet/Imagen_institucional/Manual%20ba%CC%81sico%20de%20logotipo.pdf
const kColorPrimario = Color(0xFF7F344E);
const kColorSecundario = Color(0xFF235B4E);
const kColorFondo = Color(0xFFE5E5E5);

// simple_query utiliza un modelo mas simple para facilitar las pruebas
const kRutaDatosJson = 'datos/simple_query.json';

// const kRutaDatosJson = 'datos/datos_sgp_desarrollo_v1.json';
// Para utilizar el archivo datos_sgp_desarrollo_v1.json se necesita
// actualizar las clases Datos y Servicio en el directorio modelos/
// y ejecutar la herramienta de generacion del codigo de lectura e
// interpretacion que concuerde con la estructura del archivo JSON.
//
// $ flutter pub run build_runner build
