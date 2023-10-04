import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/app/app.dart';
import 'package:piduiteun/bootstrap.dart';

void main() async {
  await Hive.initFlutter();
  unawaited(bootstrap(() => const App()));
}
