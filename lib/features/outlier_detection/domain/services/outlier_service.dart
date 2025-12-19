import '../entities/outlier_error.dart';

class OutlierService {
  int findOutlier(Iterator<int> iterator) {
    final List<int> firstThree = [];
    
    while (firstThree.length < 3) {
      if (iterator.moveNext()) {
        firstThree.add(iterator.current);
      } else {
        throw OutlierError.insufficientData;
      }
    }
    
    final n1 = firstThree[0];
    final n2 = firstThree[1];
    final n3 = firstThree[2];
    
    final evensCount = (n1.isEven ? 1 : 0) +
                       (n2.isEven ? 1 : 0) +
                       (n3.isEven ? 1 : 0);
                       
    final majorityIsEven = evensCount >= 2;
    
    for (final num in firstThree) {
      if (_isOutlier(num, majorityIsEven)) {
        return num;
      }
    }
    
    while (iterator.moveNext()) {
      final num = iterator.current;
      if (_isOutlier(num, majorityIsEven)) {
        return num;
      }
    }
    
    throw OutlierError.noOutlierFound;
  }
  
  bool _isOutlier(int number, bool majorityIsEven) {
    return number.isEven != majorityIsEven;
  }
}