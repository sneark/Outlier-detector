import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/usecases/outlier_detection_usecase.dart';
import '../../domain/entities/outlier_error.dart';

class MainViewModel extends ChangeNotifier {
  final OutlierDetectionUseCase _useCase = OutlierDetectionUseCase();

  String entryData = "";
  String result = "";
  String? errorMessage;
  
  bool isLoading = false;
  bool showResult = false; 
  
  Timer? _loadingTimer;

  void updateEntryData(String value) {
    if (entryData == value) return;
    
    entryData = value;
    
    if (errorMessage != null || showResult) {
      errorMessage = null;
      showResult = false;
      notifyListeners();
    }
  }

  Future<void> findOutlier() async {
    if (isLoading || (_loadingTimer?.isActive ?? false)) return;

    errorMessage = null;
    showResult = false;
    notifyListeners();

    _loadingTimer = Timer(const Duration(milliseconds: 200), () {
      isLoading = true;
      notifyListeners();
    });

    try {
      final int outlierValue = await _useCase.execute(entryData);

      result = outlierValue.toString();
      showResult = true; 
      notifyListeners();

    } on OutlierError catch (e) {
      _handleOutlierError(e);
      notifyListeners();
      
    } catch (e) {
      errorMessage = "Wystąpił nieoczekiwany błąd. Sprawdź poprawność danych.";
      if (kDebugMode) {
        print("Error details: $e");
      }
      notifyListeners();
      
    } finally {
      _stopLoader();
    }
  }
  
  void resetNavigation() {
    showResult = false;
  }

  void _handleOutlierError(OutlierError error) {
    switch (error) {
      case OutlierError.insufficientData:
        errorMessage = "Wprowadź co najmniej 3 liczby, aby znaleźć wynik.";
        break;
      case OutlierError.noOutlierFound:
        errorMessage = "Nie znaleziono liczby odstającej (wszystkie liczby mają tę samą parzystość).";
        break;
      }
  }

  void _stopLoader() {
    _loadingTimer?.cancel();
    _loadingTimer = null;

    if (isLoading) {
      isLoading = false;
      notifyListeners(); 
    }
  }
}