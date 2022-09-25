import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newlocation/background/background_task.dart';
import 'background/app_retain.dart';
import 'background/background_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  permissionrequest();
  runApp(MyApp());

  var channel = const MethodChannel('com.example/background_service');
  var callbackHandle = PluginUtilities.getCallbackHandle(backgroundMain);
  channel.invokeMethod('startService', callbackHandle?.toRawHandle());

  BackGroundService.instance().startCounting();
}

permissionrequest() async {
  await Geolocator.checkPermission();

  await Geolocator.requestPermission().then((value) => print("value - $value"));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Background Demo',
      home: AppRetainWidget(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Location Demo'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: BackGroundService.instance().count,
          builder: (context, count, child) {
            return Text('Counting: $count');
          },
        ),
      ),
    );
  }
}
