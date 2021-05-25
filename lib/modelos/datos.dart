import 'package:json_annotation/json_annotation.dart';

import 'servicio.dart';
part 'datos.g.dart';

// Clase que encapusla los datos leidos del archivo JSON.
@JsonSerializable()
class Datos {
  final List<Servicio> servicios;

  Datos({
    required this.servicios,
  });

  factory Datos.fromJson(Map<String, dynamic> json) =>
      _$DatosFromJson(json);
  Map<String, dynamic> toJson() => _$DatosToJson(this);
}