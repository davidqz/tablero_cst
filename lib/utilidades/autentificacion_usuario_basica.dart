import 'package:flutter/foundation.dart';

class AutentificacionUsuarioBasica extends ChangeNotifier {
  bool _autentificado = false;

  bool get auntentificadoCorrectamente => _autentificado;

  AutentificacionUsuarioBasica();

  bool autentificarUsuario(
      {required String nombre, required String contrasena}) {
    final indiceUsuarioEncontrado =
        _listaUsuarios.indexWhere((u) => u.nombre == nombre);
    if (indiceUsuarioEncontrado != -1 &&
        _listaUsuarios[indiceUsuarioEncontrado].contrasena == contrasena) {
      print("Usuario '$nombre' autentificado correctamente");
      _autentificado = true;
      notifyListeners();
      return true;
    }
    print('Usuario o contraseña invalidos');
    _autentificado = false;
    notifyListeners();
    return false;
  }

  final _listaUsuarios = [
    Usuario(nombre: 'admin', contrasena: '1234'),
  ];
}

class Usuario {
  String nombre;
  String contrasena;

  Usuario({required this.nombre, required this.contrasena});
}
