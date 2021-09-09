class Columna<T> {
  String encabezado;
  String Function(T t) extraerTexto;
  bool alineacionDerecha;
  Function(int, bool)? alOrdenar;

  Columna({
    required this.encabezado,
    required this.extraerTexto,
    this.alineacionDerecha = false,
    this.alOrdenar,
  });
}
