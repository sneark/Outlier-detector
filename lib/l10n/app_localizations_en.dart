// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Outlier Detector';

  @override
  String get inputLabel => 'Enter numbers (e.g. 5,3,18)';

  @override
  String get searchButton => 'Find Outlier';

  @override
  String get resultTitle => 'Result:';

  @override
  String get errorInsufficientData => 'Please enter at least 3 numbers.';

  @override
  String get errorNoOutlier =>
      'No outlier found (all numbers have same parity).';

  @override
  String get errorInvalidFormat => 'Invalid format. Check your input.';

  @override
  String get errorUnknown => 'An unexpected error occurred.';
}
