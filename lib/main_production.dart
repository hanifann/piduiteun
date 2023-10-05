import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/app/app.dart';
import 'package:piduiteun/bootstrap.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Expenditure>(ExpenditureAdapter());
  await init();
  unawaited(bootstrap(() => const App()));
}
