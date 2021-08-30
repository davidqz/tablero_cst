// Archivo necesario para eliminar el '#' de la url
// https://flutter.dev/docs/development/ui/navigation/url-strategies

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}
