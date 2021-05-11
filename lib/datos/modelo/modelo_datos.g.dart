// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelo_datos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModeloDatos _$ModeloDatosFromJson(Map<String, dynamic> json) {
  return ModeloDatos(
    (json['servicios'] as List<dynamic>)
        .map((e) => Servicio.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ModeloDatosToJson(ModeloDatos instance) =>
    <String, dynamic>{
      'servicios': instance.servicios,
    };

Servicio _$ServicioFromJson(Map<String, dynamic> json) {
  return Servicio(
    json['idServicio'] as String,
    json['interno'] as String,
    json['nombreCorto'] as String,
    json['areaResponsable'] as String,
    json['estatus'] as String,
    json['alcance'] as String,
    Cliente.fromJson(json['cliente'] as Map<String, dynamic>),
    json['fechaFinProgramada'] as String,
    json['fechaInicioProgramada'] as String,
    (json['avances'] as List<dynamic>)
        .map((e) => Avance.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ServicioToJson(Servicio instance) => <String, dynamic>{
      'idServicio': instance.idServicio,
      'interno': instance.interno,
      'nombreCorto': instance.nombreCorto,
      'areaResponsable': instance.areaResponsable,
      'estatus': instance.estatus,
      'alcance': instance.alcance,
      'cliente': instance.cliente,
      'fechaInicioProgramada': instance.fechaInicioProgramada,
      'fechaFinProgramada': instance.fechaFinProgramada,
      'avances': instance.avances,
    };

Cliente _$ClienteFromJson(Map<String, dynamic> json) {
  return Cliente(
    json['nombre'] as String,
    json['sector'] as String,
    json['pais'] as String,
    json['estado'] as String,
    json['ciudad'] as String,
  );
}

Map<String, dynamic> _$ClienteToJson(Cliente instance) => <String, dynamic>{
      'nombre': instance.nombre,
      'sector': instance.sector,
      'pais': instance.pais,
      'estado': instance.estado,
      'ciudad': instance.ciudad,
    };

Avance _$AvanceFromJson(Map<String, dynamic> json) {
  return Avance(
    json['mes'] as int?,
    json['anyo'] as int?,
    json['porcentajeAvance'] as int?,
  );
}

Map<String, dynamic> _$AvanceToJson(Avance instance) => <String, dynamic>{
      'mes': instance.mes,
      'anyo': instance.anyo,
      'porcentajeAvance': instance.porcentajeAvance,
    };
