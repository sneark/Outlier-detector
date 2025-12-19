import 'package:flutter_test/flutter_test.dart';
import 'package:decoder/features/outlier_detection/domain/services/outlier_service.dart';
import 'package:decoder/features/outlier_detection/domain/entities/outlier_error.dart';
import 'package:decoder/features/outlier_detection/data/string_input_parser.dart';

void main() {
  late OutlierService service;
  
  setUp(() {
    service = OutlierService();
  });
  
  group('OutlierService - Logic', () {
    test('finds odd outlier in evens', () {
      const input = "2, 4, 0, 100, 4, 11, 2602, 36";
      final parser = StringInputParser(input);
      final outlier = service.findOutlier(parser.iterator);
      expect(outlier, 11);
    });
    
    test('finds even outlier in odds', () {
      const input = "160, 3, 1719, 19, 11, 13, -21";
      final parser = StringInputParser(input);
      final outlier = service.findOutlier(parser.iterator);
      expect(outlier, 160);
    });
    
    test('finds outlier at the start', () {
      const input = "1, 2, 4, 6, 8";
      final parser = StringInputParser(input);
      final outlier = service.findOutlier(parser.iterator);
      expect(outlier, 1);
    });
    
    test('finds outlier at the 3rd position', () {
      const input = "2, 4, 1, 6, 8";
      final parser = StringInputParser(input);
      final outlier = service.findOutlier(parser.iterator);
      expect(outlier, 1);
    });
    
    test('finds outlier at the end', () {
      const input = "2, 4, 6, 8, 1";
      final parser = StringInputParser(input);
      final outlier = service.findOutlier(parser.iterator);
      expect(outlier, 1);
    });

    test('handles negative integers correctly', () {
      const input = "-2, -4, -100, -7";
      final parser = StringInputParser(input);
      final outlier = service.findOutlier(parser.iterator);
      expect(outlier, -7);
    });
  });
  
  group('OutlierService - Parser Integration', () {
    test('handles messy input with whitespace and noise', () {
      const input = "2,   4, \n invalid_text, 11, 8";
      final parser = StringInputParser(input);
      final outlier = service.findOutlier(parser.iterator);
      expect(outlier, 11);
    });

    test('parser handles negative numbers specifically', () {
       final parser = StringInputParser("-5 -10 5").iterator;
       expect(parser.moveNext(), true); expect(parser.current, -5);
       expect(parser.moveNext(), true); expect(parser.current, -10);
       expect(parser.moveNext(), true); expect(parser.current, 5);
       expect(parser.moveNext(), false);
    });
  });
  
  group('OutlierService - Error Handling', () {
    test('throws insufficientData for short inputs', () {
      const inputs = ["", "1", "1, 2"];
      
      for (final input in inputs) {
        final parser = StringInputParser(input);
        expect(
          () => service.findOutlier(parser.iterator), 
          throwsA(OutlierError.insufficientData),
          reason: "Should throw for input: $input"
        );
      }
    });

    test('throws noOutlierFound when all numbers have same parity', () {
      const input = "2, 4, 6, 8, 100";
      final parser = StringInputParser(input);
      
      expect(
          () => service.findOutlier(parser.iterator), 
          throwsA(OutlierError.noOutlierFound)
      );
    });
  });
  
  group('Performance', () {
    test('handles 1 Million items efficiently', () {
      final buffer = StringBuffer();
      for (int i = 0; i < 1000000; i++) {
        buffer.write("2, ");
      }
      buffer.write("1"); 
      final largeString = buffer.toString();
      
      final stopwatch = Stopwatch()..start();
      
      final parser = StringInputParser(largeString);
      final outlier = service.findOutlier(parser.iterator);
      
      stopwatch.stop();
      
      expect(outlier, 1);
      
      print("Time for 1M items logic: ${stopwatch.elapsedMilliseconds} ms");
      
      expect(stopwatch.elapsedMilliseconds, lessThan(2000)); 
    });
  });
}