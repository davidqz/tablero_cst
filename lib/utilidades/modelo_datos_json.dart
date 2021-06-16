import 'package:json_annotation/json_annotation.dart';

part 'modelo_datos_json.g.dart';

// Clase que encapusla los datos leidos del archivo JSON.
//
// IMPORTANTE: Cambios en este archivo requieren de re-ejecutar la herramienta
// de generación automática de codigo intermediario (modelo_datos_json.g.dart)
// para la correcta lectura de archivos JSON:
//
// flutter pub run build_runner build
//

// Modelo Datos v2
@JsonSerializable()
class DatosJson {
  final List<Servicio> servicios;
  final Descriptores? descriptores;

  DatosJson({
    required this.servicios,
    this.descriptores,
  });

  factory DatosJson.fromJson(Map<String, dynamic> json) =>
      _$DatosJsonFromJson(json);
}

@JsonSerializable()
class Servicio {
  final int idServicio;
  final String estatus;
  final String interno;
  final String nombreCorto;
  final String nombreLargo;
  final String sedeResponsable;
  final String areaVinculacionResponsable;
  final String zonaInfluencia;
  final Cliente cliente;
  @JsonKey(name: 'Finanzas')
  final Finanzas finanzas;
  @JsonKey(name: 'Procesos')
  final Procesos procesos;
  final List<Avance> avances;
  @JsonKey(name: 'Personas')
  final List<Persona> personas;

  Servicio({
    required this.idServicio,
    required this.estatus,
    required this.interno,
    required this.nombreCorto,
    required this.nombreLargo,
    required this.sedeResponsable,
    required this.areaVinculacionResponsable,
    required this.zonaInfluencia,
    required this.cliente,
    required this.finanzas,
    required this.procesos,
    required this.avances,
    required this.personas,
  });

  double get ultimoAvanceReportado {
    if (avances.isEmpty) {
      return 0;
    }
    var anyo = avances.first.anyo;
    var mes = avances.first.mes;
    var porcentajeAvance = avances.first.porcentajeAvance;

    for (var avance in avances) {
      if (avance.anyo > anyo) {
        anyo = avance.anyo;
        mes = avance.mes;
        porcentajeAvance = avance.porcentajeAvance;
      } else if (avance.anyo == anyo) {
        if (avance.mes > mes) ;
        mes = avance.mes;
        porcentajeAvance = avance.porcentajeAvance;
      }
    }
    return porcentajeAvance / 100.0;
  }

  factory Servicio.fromJson(Map<String, dynamic> json) =>
      _$ServicioFromJson(json);
}

@JsonSerializable()
class Cliente {
  final int idCliente;
  final String nombre;
  final String sector;
  final String giro;
  final String tamanioOrganizacion;
  final String pais;
  final String estado;
  final String ciudad;

  Cliente({
    required this.idCliente,
    required this.nombre,
    required this.sector,
    required this.giro,
    required this.tamanioOrganizacion,
    required this.pais,
    required this.estado,
    required this.ciudad,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) =>
      _$ClienteFromJson(json);
}

@JsonSerializable()
class Finanzas {
  final int montoVariable;
  final int idTipoMoneda;
  final double precioSinIVA;
  final List<PlaneacionGastos> planeacionGastos;
  final List<IngresoEgreso> ingresos;
  final List<IngresoEgreso> egresos;
  final List<PagoProgramado> pagosProgramados;

  Finanzas({
    required this.montoVariable,
    required this.idTipoMoneda,
    required this.precioSinIVA,
    required this.planeacionGastos,
    required this.ingresos,
    required this.egresos,
    required this.pagosProgramados,
  });

  double get totalIngresos {
    var sumaIngresos = 0.0;
    for (var ingresoEgreso in ingresos) {
      sumaIngresos += ingresoEgreso.montoSinIVA;
    }
    return sumaIngresos;
  }

  double get totalEgresos {
    var sumaEgresos = 0.0;
    for (var ingresoEgreso in egresos) {
      sumaEgresos += ingresoEgreso.montoSinIVA;
    }
    return sumaEgresos;
  }

  factory Finanzas.fromJson(Map<String, dynamic> json) =>
      _$FinanzasFromJson(json);
}

@JsonSerializable()
class PlaneacionGastos {
  final int numVersionPlanGasto;
  final double montoSinIVA;
  final int mes;
  final int anyo;
  final int idTipoConceptoIngresoEgreso;

  PlaneacionGastos({
    required this.numVersionPlanGasto,
    required this.montoSinIVA,
    required this.mes,
    required this.anyo,
    required this.idTipoConceptoIngresoEgreso,
  });

  factory PlaneacionGastos.fromJson(Map<String, dynamic> json) =>
      _$PlaneacionGastosFromJson(json);
}

@JsonSerializable()
class IngresoEgreso {
  final double montoSinIVA;
  final int mes;
  final int anyo;
  final int idTipoConceptoIngresoEgreso;

  IngresoEgreso({
    required this.montoSinIVA,
    required this.mes,
    required this.anyo,
    required this.idTipoConceptoIngresoEgreso,
  });

  factory IngresoEgreso.fromJson(Map<String, dynamic> json) =>
      _$IngresoEgresoFromJson(json);
}

@JsonSerializable()
class PagoProgramado {
  final String fechaPago;
  final double montoSinIVA;
  final String fechaRegistro;
  final String fechaModificacion;

  PagoProgramado({
    required this.fechaPago,
    required this.montoSinIVA,
    required this.fechaRegistro,
    required this.fechaModificacion,
  });

  factory PagoProgramado.fromJson(Map<String, dynamic> json) =>
      _$PagoProgramadoFromJson(json);
}

@JsonSerializable()
class Procesos {
  final String fechaInicioProgramada;
  final String fechaFinProgramada;
  final String fechaInicioTecnicoProgramada;
  final String fechaFinTecnicoProgramada;
  final String fechaInicioReal;
  final String fechaCierreTecnico;
  final String fechaCierreModificada;
  final List<SolicitudCambioFechaCierre> solicitudesCambioFechaCierre;

  Procesos({
    required this.fechaInicioProgramada,
    required this.fechaFinProgramada,
    required this.fechaInicioTecnicoProgramada,
    required this.fechaFinTecnicoProgramada,
    required this.fechaInicioReal,
    required this.fechaCierreTecnico,
    required this.fechaCierreModificada,
    required this.solicitudesCambioFechaCierre,
  });

  factory Procesos.fromJson(Map<String, dynamic> json) =>
      _$ProcesosFromJson(json);
}

@JsonSerializable()
class SolicitudCambioFechaCierre {
  final String fechaOriginal;
  final String fechaNueva;
  final String fechaSolicitud;
  final String estatusSolicitud;

  SolicitudCambioFechaCierre({
    required this.fechaOriginal,
    required this.fechaNueva,
    required this.fechaSolicitud,
    required this.estatusSolicitud,
  });

  factory SolicitudCambioFechaCierre.fromJson(Map<String, dynamic> json) =>
      _$SolicitudCambioFechaCierreFromJson(json);
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
}

@JsonSerializable()
class Persona {
  final int idPersona;
  final String delCIMAT;
  final String puestoCategoria;
  final List<HorasTrabajadas> horasTrabajadas;

  Persona({
    required this.idPersona,
    required this.delCIMAT,
    required this.puestoCategoria,
    required this.horasTrabajadas,
  });

  factory Persona.fromJson(Map<String, dynamic> json) =>
      _$PersonaFromJson(json);
}

@JsonSerializable()
class HorasTrabajadas {
  final int mes;
  final int anyo;
  final double horasTrabajadas;

  HorasTrabajadas({
    required this.mes,
    required this.anyo,
    required this.horasTrabajadas,
  });

  factory HorasTrabajadas.fromJson(Map<String, dynamic> json) =>
      _$HorasTrabajadasFromJson(json);
}

@JsonSerializable()
class Descriptores {
  final List<Moneda> monedas;
  final List<ConceptoIngresoEgreso> conceptosIngresosEgresos;

  const Descriptores({
    required this.monedas,
    required this.conceptosIngresosEgresos,
  });

  factory Descriptores.fromJson(Map<String, dynamic> json) =>
      _$DescriptoresFromJson(json);
}

@JsonSerializable()
class Moneda {
  int idTipoMoneda;
  String tipoMoneda;

  Moneda({
    required this.idTipoMoneda,
    required this.tipoMoneda,
  });

  factory Moneda.fromJson(Map<String, dynamic> json) => _$MonedaFromJson(json);
}

@JsonSerializable()
class ConceptoIngresoEgreso {
  int idTipoConceptoIngresoEgreso;
  String tipoConceptoIngresoEgreso;

  ConceptoIngresoEgreso({
    required this.idTipoConceptoIngresoEgreso,
    required this.tipoConceptoIngresoEgreso,
  });

  factory ConceptoIngresoEgreso.fromJson(Map<String, dynamic> json) =>
      _$ConceptoIngresoEgresoFromJson(json);
}
