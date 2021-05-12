import 'package:json_annotation/json_annotation.dart';

/// This allows the `ModeloDatos` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'modelo_datos.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class ModeloDatos {
  List<Servicio> servicios;

  ModeloDatos(this.servicios);

  factory ModeloDatos.fromJson(Map<String, dynamic> json) =>
      _$ModeloDatosFromJson(json);
  Map<String, dynamic> toJson() => _$ModeloDatosToJson(this);
}

@JsonSerializable()
class Servicio {
  String idServicio;
  String interno;
  String nombreCorto;
  String areaResponsable;
  String estatus;
  String alcance;
  Cliente cliente;
  String fechaInicioProgramada;
  String fechaFinProgramada;
  List<Avance> avances;

  Servicio(
      this.idServicio,
      this.interno,
      this.nombreCorto,
      this.areaResponsable,
      this.estatus,
      this.alcance,
      this.cliente,
      this.fechaFinProgramada,
      this.fechaInicioProgramada,
      this.avances);

  factory Servicio.fromJson(Map<String, dynamic> json) =>
      _$ServicioFromJson(json);
  Map<String, dynamic> toJson() => _$ServicioToJson(this);
}

@JsonSerializable()
class Cliente {
  String nombre;
  String sector;
  String pais;
  String estado;
  String ciudad;

  Cliente(this.nombre, this.sector, this.pais, this.estado, this.ciudad);

  factory Cliente.fromJson(Map<String, dynamic> json) =>
      _$ClienteFromJson(json);
  Map<String, dynamic> toJson() => _$ClienteToJson(this);
}

@JsonSerializable()
class Avance {
  int? mes;
  int? anyo;
  int? porcentajeAvance;

  Avance(this.mes, this.anyo, this.porcentajeAvance);

  factory Avance.fromJson(Map<String, dynamic> json) => _$AvanceFromJson(json);
  Map<String, dynamic> toJson() => _$AvanceToJson(this);
}
