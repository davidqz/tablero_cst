import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

// Ruta y nombre de archivo JSON de origen.
const kRutaDatosJson = 'datos/datos_sgp_desarrollo_v2.json';

// Texto que aparece como titulo de la pagina web.
const kTituloPaginaWeb = 'Tablero de Indicadores CST';

const kColorFondo = Color(0xFFE5E5E5);
const kColorPrimario = Color(0xFF235B4E);
const kColorSecundario = Color(0xFF7F344E);

const kAlturaBannerSuperior = 60.0;
const kAlturaGraficas = 150.0;
const kRenglonesPorPagina = 5;

// Formato de fecha utilizado en archivo de lectura de datos (JSON)
final kFormatoFechaLectura = DateFormat('yyyy-MM-dd', 'es_MX');
// Formato de fecha utilizado en la interfaz de usuario
final kFormatoFechaInterfaz = DateFormat('dd/MM/yyyy', 'es_MX');
final kFormatoPorcentaje = NumberFormat.percentPattern();
final kFormatoMoneda = NumberFormat.simpleCurrency();
final kFormatoCompacto = NumberFormat.compact();
