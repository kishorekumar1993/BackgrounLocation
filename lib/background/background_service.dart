import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'add_intial.dart';
import 'filestorage.dart';

class BackGroundService {
  factory BackGroundService.instance() => _instance;

  BackGroundService._internal();

  static final _instance = BackGroundService._internal();

  final _counter = InitialValue();

  ValueListenable<int> get count => _counter.count;
  final storage = FileStorage();
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  LocationPermission? permission;

  _getCurrentLocation() async {

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse) {
      await Geolocator.requestPermission()
          .then((value) => print("value - $value"));
    }
    if (permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      _counter.increment();
      print(position);
      print("@no:${_counter.count.value},$position");
      storage.write(
          "@no:${_counter.count.value},$position");
    }
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }

  void startCounting() {
    Stream.periodic(const Duration(seconds: 10)).listen((_) {
      _getCurrentLocation();
    });
  }
}
