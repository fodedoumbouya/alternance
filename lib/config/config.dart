import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();

    // chargement du fichier env
    await dotenv.load(fileName: ".env");

    runApp();
  }
}
