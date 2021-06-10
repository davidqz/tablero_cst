import 'package:json_annotation/json_annotation.dart';

part 'modelo_datos_json.g.dart';

// Clase que encapusla los datos leidos del archivo JSON.
//
// IMPORTANTE: Cambios en este archivo requieren de re-ejecutar la herramienta
// de generación automática de archivos intermediarios de lectura de JSON:
// $ flutter pub run build_runner build
//
@JsonSerializable()
class DatosJson {
  final List<Servicio> servicios;

  DatosJson({
    required this.servicios,
  });

  factory DatosJson.fromJson(Map<String, dynamic> json) =>
      _$DatosJsonFromJson(json);

  Map<String, dynamic> toJson() => _$DatosJsonToJson(this);
}

// Modelo Datos Servicio v1
@JsonSerializable()
class Servicio {
  final String idServicio;
  final String interno;
  final String nombreCorto;
  final String areaResponsable;
  final String estatus;
  final String alcance;
  final Cliente cliente;
  final String fechaInicioProgramada;
  final String fechaFinProgramada;
  final List<Avance> avances;
  // final List<Transaccion> ingresos;
  // final List<Transaccion> gastos;

  Servicio({
    required this.idServicio,
    required this.interno,
    required this.nombreCorto,
    required this.areaResponsable,
    required this.estatus,
    required this.alcance,
    required this.cliente,
    required this.fechaFinProgramada,
    required this.fechaInicioProgramada,
    required this.avances,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) =>
      _$ServicioFromJson(json);

  Map<String, dynamic> toJson() => _$ServicioToJson(this);
}

@JsonSerializable()
class Cliente {
  final String nombre;
  final String sector;
  final String pais;
  final String estado;
  final String ciudad;

  Cliente({
    required this.nombre,
    required this.sector,
    required this.pais,
    required this.estado,
    required this.ciudad,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) =>
      _$ClienteFromJson(json);

  Map<String, dynamic> toJson() => _$ClienteToJson(this);
}

@JsonSerializable()
class Avance {
  final int mes;
  final int anyo;
  final int porcentajeAvance;

  Avance({
    required this.mes,
    required this.anyo,
    required this.porcentajeAvance,
  });

  factory Avance.fromJson(Map<String, dynamic> json) => _$AvanceFromJson(json);

  Map<String, dynamic> toJson() => _$AvanceToJson(this);
}

@JsonSerializable()
class Transaccion {
  final double monto;
  final int mes;
  final int anyo;

  Transaccion({
    required this.monto,
    required this.mes,
    required this.anyo,
  });

  factory Transaccion.fromJson(Map<String, dynamic> json) =>
      _$TransaccionFromJson(json);

  Map<String, dynamic> toJson() => _$TransaccionToJson(this);
}
