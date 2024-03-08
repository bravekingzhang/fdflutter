import 'package:fdflutter/core/di/injection_container.dart';
import 'package:fdflutter/core/localization/config.dart';
import 'package:fdflutter/core/routing/router.dart';
import 'package:fdflutter/core/utils/logger.dart';
import 'package:fdflutter/data/datasources/local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  setupLocator();
  await initHive();
  runApp(
    // To install Riverpod, we need to add this widget above everything else.
    // This should not be inside "MyApp" but as direct parameter to "runApp".
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(
      mapLocales: mapLocales,
      initLanguageCode: 'en', //should be managed by global state setting
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    logger.d('current language: $locale');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: const RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
      theme: ThemeData(fontFamily: _localization.fontFamily),
      localizationsDelegates: _localization.localizationsDelegates,
      supportedLocales: _localization.supportedLocales,
    );
  }
}
