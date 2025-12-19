import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/usecases/outlier_detection_usecase.dart';
import '../../domain/entities/outlier_error.dart';

class MainViewModel extends ChangeNotifier {
  final OutlierDetectionUseCase useCase;

  String entryData = "";
  String result = "";
  OutlierError? errorMessage;
  
  bool isLoading = false;
  bool showResult = false; 
  
  Timer? _loadingTimer;

  MainViewModel({required this.useCase});

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
      final int outlierValue = await useCase.execute(entryData);

      result = outlierValue.toString();
      showResult = true; 
      notifyListeners();

    } on OutlierError catch (e) {
      errorMessage = e;
      notifyListeners();
      
    } catch (e) {
      errorMessage = OutlierError.unknown;
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



  void _stopLoader() {
    _loadingTimer?.cancel();
    _loadingTimer = null;

    if (isLoading) {
      isLoading = false;
      notifyListeners(); 
    }
  }
}