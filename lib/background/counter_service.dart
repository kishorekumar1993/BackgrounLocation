import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'counter.dart';
import 'filestorage.dart';

class CounterService {
  factory CounterService.instance() => _instance;

  CounterService._internal();

  static final _instance = CounterService._internal();

  final _counter = Counter();

  ValueListenable<int> get count => _counter.count;
  final storage = FileStorage();
  Position? _currentPosition;
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  LocationPermission? permission;

  _getCurrentLocation() async {
    var prefs = await SharedPreferences.getInstance();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse) {
      await Geolocator.requestPermission()
          .then((value) => print("value - $value"));
    }
    if (permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      var latitudevalue = position?.latitude;
      var longitudevalue = position?.longitude;
      _counter.increment();
      print(position);
      print("@no:${_counter.count.value},$position");
      storage.write(
          "@no:${_counter.count.value},latitude${position?.latitude}, longitude ${position?.longitude}");
    }
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }

  void startCounting() {
    Stream.periodic(Duration(seconds: 10)).listen((_) {
      _getCurrentLocation();
    });
  }
}
