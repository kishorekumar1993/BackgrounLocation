import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialValue {
  InitialValue() {
    _readCount().then((count) => _count.value = count);
  }

  final ValueNotifier<int> _count = ValueNotifier(0);

  ValueListenable<int> get count => _count;

  void increment() {
    _count.value++;
    _writeCount(_count.value);
  }

  Future<int> _readCount() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt('InitialValue.count') ?? 0;
  }

  Future<Future<bool>> _writeCount(int count) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setInt('InitialValue.count', count);
  }
}
