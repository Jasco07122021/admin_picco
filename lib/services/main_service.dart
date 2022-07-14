import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'hive_service.dart';

class MainService {
  static Future<void> init() async {
    Provider.debugCheckInvalidValueType = null;

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await Hive.initFlutter();
    await Hive.openBox(HiveService.DB_NAME);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
