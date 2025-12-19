// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Detektor Odchyleń';

  @override
  String get inputLabel => 'Wprowadź liczby (np. 5,3,18)';

  @override
  String get searchButton => 'Wyszukaj';

  @override
  String get resultTitle => 'Wynik:';

  @override
  String get errorInsufficientData => 'Wprowadź co najmniej 3 liczby.';

  @override
  String get errorNoOutlier => 'Nie znaleziono liczby odstającej.';

  @override
  String get errorInvalidFormat => 'Błędny format danych.';

  @override
  String get errorUnknown => 'Wystąpił nieoczekiwany błąd.';
}
