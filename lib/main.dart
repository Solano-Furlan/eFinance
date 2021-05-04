import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization.dart';
import './pages/home.dart';
import './pages/settings.dart';
import './providers/calculator_provider.dart';
import './providers/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider languageProvider = LanguageProvider();
  await languageProvider.fetchLocale();
  runApp(
    MyApp(
      laguageProvider: languageProvider,
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
}

class MyApp extends StatelessWidget {
  final LanguageProvider laguageProvider;

  MyApp({this.laguageProvider});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CalculatorProvider()),
        ChangeNotifierProvider.value(value: LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(builder: (context, model, child) {
        print(model.appLocal);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: model.appLocal,
          supportedLocales: [
            const Locale('en'),
            const Locale('pt'),
            const Locale('es'),
            const Locale('de'),
            const Locale('fr'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Home.routeName,
          routes: {
            Home.routeName: (ctx) => Home(),
            Settings.routeName: (ctx) => Settings(),
          },
        );
      }),
    );
  }
}
