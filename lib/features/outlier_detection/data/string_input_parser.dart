class StringInputParser extends Iterable<int> {
  final String text;
  
  StringInputParser(this.text);
  
  @override
  Iterator<int> get iterator => _StringInputIterator(text);
}

class _StringInputIterator implements Iterator<int> {
  final String text;
  int _currentIndex = 0;
  int? _current;
  
  _StringInputIterator(this.text);
  
  @override
  int get current => _current!;

  @override
  bool moveNext() {
    final length = text.length;
    while (_currentIndex < length) {
      while (_currentIndex < length) {
        final charCode = text.codeUnitAt(_currentIndex);
        if ((charCode >= 48 && charCode <= 57) || charCode == 45) { 
          break;
        }
        _currentIndex++;
      }
      
      if (_currentIndex >= length) {
        return false;
      }
      
      final start = _currentIndex;
      
      bool isNegative = false;
      if (text.codeUnitAt(_currentIndex) == 45) { // '-'
        isNegative = true;
        _currentIndex++;
      }
      
      while (_currentIndex < length) {
        final charCode = text.codeUnitAt(_currentIndex);
        if (charCode < 48 || charCode > 57) { // not 0-9
          break;
        }
        _currentIndex++;
      }
      
      if (isNegative && _currentIndex == start + 1) {
          continue;
      }
      
      final numberSubstring = text.substring(start, _currentIndex);
      final validInteger = int.tryParse(numberSubstring);
      
      if (validInteger != null) {
        _current = validInteger;
        return true;
      } else {
        // overflow int
        continue;
      }
    }
    
    return false;
  }
}
