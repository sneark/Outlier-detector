import 'package:flutter/foundation.dart';
import '../../data/string_input_parser.dart'; 
import '../services/outlier_service.dart'; 

int _isolateEntryPoint(String text) {
  final parser = StringInputParser(text);
  
  final service = OutlierService();
  
  return service.findOutlier(parser.iterator);
}

class OutlierDetectionUseCase {
  Future<int> execute(String input) async {
    return await compute(_isolateEntryPoint, input);
  }
}