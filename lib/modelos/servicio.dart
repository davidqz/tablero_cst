import 'package:json_annotation/json_annotation.dart';
part 'servicio.g.dart';

@JsonSerializable()
class Servicio {
  final String idServicio;
  final int interno;
  final String estatus;
  final String clave;
  final double montoProyecto;
  final String nombreCorto;
  final String sede;
  final List<Transaccion> ingresos;
  final List<Transaccion> gastos;

  Servicio({
    required this.idServicio,
    required this.interno,
    required this.estatus,
    required this.clave,
    required this.montoProyecto,
    required this.nombreCorto,
    required this.sede,
    required this.ingresos,
    required this.gastos,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) =>
      _$ServicioFromJson(json);
  Map<String, dynamic> toJson() => _$ServicioToJson(this);
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
