class Filtro {
  final String nombre;
  final Function alSeleccionarlo;
  bool seleccionado = false;

  Filtro({
    required this.nombre,
    required this.alSeleccionarlo,
  });
}
