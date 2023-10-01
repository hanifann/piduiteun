import 'package:flutter/material.dart';
import 'package:piduiteun/l10n/l10n.dart';
import 'package:piduiteun/routes/route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromRGBO(0, 103, 127, 1),
        fontFamily: 'Nunito',
        // colorScheme: const ColorScheme(
        //   background: Color.fromRGBO(251, 252, 254, 1), 
        //   onBackground: Color.fromRGBO(25, 28, 29, 1),
        //   brightness: Brightness.light, 
        //   primary: Color.fromRGBO(0, 103, 127, 1), 
        //   onPrimary: Colors.white, 
        //   secondary: Color.fromRGBO(45, 107, 39, 1), 
        //   onSecondary: Colors.white, 
        //   error: Color.fromRGBO(186, 26, 26, 1), 
        //   onError: Colors.white, 
        //   surface: Color.fromRGBO(251, 252, 254, 1),
        //   onSurface: Color.fromRGBO(25, 28, 29, 1),
        // ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
