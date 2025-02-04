import 'package:cbl_flutter/cbl_flutter.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Padrão para flutter inicializar
  try {
    await CouchbaseLiteFlutter.init();
    runApp(MyApp());
  } catch (e) {
    print('Erro ao inicializar Couchbase Lite: $e');
  }
}
