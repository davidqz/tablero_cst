class Usuario {
  String _nombre = '';
  bool _autentificado = false;

  Usuario();

  void autentificacionExitosa(String nombre) {
    _nombre = nombre;
    _autentificado = true;
    print('Usuario: $nombre autentificado correctamente');
  }

  String get nombre => _nombre;

  bool get auntentificado => _autentificado;
}
