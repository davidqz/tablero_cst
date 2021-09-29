import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tablero_cst/utilidades/autentificacion_usuario_basica.dart';
import 'package:tablero_cst/widgets/verificador_usuario.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'pantallas/pantalla_autentificacion.dart';
import 'utilidades/almacen_datos.dart';
import 'utilidades/constantes.dart';
import 'utilidades/notificador_tabla_servicios.dart';

void main() {
  configureApp();
  runApp(const TableroCstApp());
}

class TableroCstApp extends StatelessWidget {
  const TableroCstApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AutentificacionUsuarioBasica()),
          ChangeNotifierProvider(create: (_) => AlmacenDatos()),
          ChangeNotifierProxyProvider<AlmacenDatos, NotificadorTablaServicios>(
              create: (_) => NotificadorTablaServicios(),
              update: (_, almacen, notificadorTabla) =>
                  (notificadorTabla == null)
                      ? NotificadorTablaServicios()
                      : notificadorTabla
                    ..actualizarServicios(almacen.servicios)),
        ],
        child: MaterialApp(
          title: kTituloPaginaWeb,
          initialRoute: kRutaPrincipal,
          routes: <String, WidgetBuilder>{
            kRutaPrincipal: (_) => const VerificadorUsuario(),
            kRutaAutentificacion: (_) => const PantallaAutentificacion(),
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale('es', 'MX')],
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: kColorPrimario,
              secondary: kColorSecundario,
              background: kColorFondo,
            ),
            primaryColor: kColorPrimario,
            accentColor: kColorSecundario,
            backgroundColor: kColorFondo,
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
              isDense: true,
              filled: true,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: kColorSecundario,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            chipTheme: ChipTheme.of(context).copyWith(
              backgroundColor: Colors.black26,
              elevation: 2,
              selectedColor: kColorSecundario,
              checkmarkColor: Colors.white,
              labelStyle: ThemeData.fallback()
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ));
  }
}
