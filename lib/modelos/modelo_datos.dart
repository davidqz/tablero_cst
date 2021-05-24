import 'package:json_annotation/json_annotation.dart';
part 'modelo_datos.g.dart';

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
  int interno;
  String estatus;
  String clave;
  double montoProyecto;
  String nombreCorto;
  String sede;

  List<Transaccion> ingresos;
  List<Transaccion> gastos;

  Servicio(
      this.idServicio,
      this.interno,
      this.estatus,
      this.clave,
      this.montoProyecto,
      this.nombreCorto,
      this.sede,
      this.ingresos,
      this.gastos,
      );

  factory Servicio.fromJson(Map<String, dynamic> json) =>
      _$ServicioFromJson(json);
  Map<String, dynamic> toJson() => _$ServicioToJson(this);
}

@JsonSerializable()
class Transaccion {
  double monto;
  int mes;
  int anyo;

  Transaccion(
      this.monto,
      this.mes,
      this.anyo,
      );

  factory Transaccion.fromJson(Map<String, dynamic> json) =>
      _$TransaccionFromJson(json);
  Map<String, dynamic> toJson() => _$TransaccionToJson(this);
}
