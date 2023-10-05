import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/app/app.dart';
import 'package:piduiteun/bootstrap.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenditureAdapter());
  unawaited(bootstrap(() => const App()));
}
