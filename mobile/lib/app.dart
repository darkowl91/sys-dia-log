import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile/service/measurement_service.dart';
import 'package:mobile/service/measurement_store.dart';
import 'package:mobile/views/home_view.dart';
import 'package:mobile/views/new_measurement_view.dart';
import 'package:provider/provider.dart';

class SysDiaLogApp extends StatelessWidget {
  const SysDiaLogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MeasurementStore(MeasurementService.create()))
      ],
      child: MaterialApp(
        title: 'Sys Dia Log',
        restorationScopeId: 'sys_dia_log_app_id',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'Roboto'),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: const HomeView(),
        localizationsDelegates: [
          FlutterI18nDelegate(
              keySeparator: '.',
              translationLoader: FileTranslationLoader(
                  basePath: 'assets/i18n', useCountryCode: true)),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
        routes: {
          HomeView.routeName: (context) => const HomeView(),
          NewMeasurementView.routeName: (context) => const NewMeasurementView()
        },
      ),
    );
  }
}
