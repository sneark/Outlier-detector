import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'injection_container.dart';
import 'features/outlier_detection/presentation/pages/main_page.dart';
import 'features/outlier_detection/presentation/viewmodels/main_view_model.dart';

class DecoderApp extends StatelessWidget {
  const DecoderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detektor',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      
      localizationsDelegates: const [
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), 
        Locale('pl'), 
      ],

      home: ChangeNotifierProvider(
        create: (_) => sl<MainViewModel>(), 
        child: const MainPage(),
      ),
    );
  }
}