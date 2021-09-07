class ColumnaTabla<T> {
  String encabezado;
  String Function(T t) extraerTexto;
  bool alineacionDerecha;
  Function(int, bool)? alOrdenar;

  ColumnaTabla({
    required this.encabezado,
    required this.extraerTexto,
    this.alineacionDerecha = false,
    this.alOrdenar,
  });
}
