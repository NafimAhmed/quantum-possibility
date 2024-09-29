import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/utils/loader.dart';
import 'quantum_possibilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  configLoader();
  runApp(
    const QuantumPossibilities(),
  );
}
