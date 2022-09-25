import 'package:flutter/cupertino.dart';

import 'background_service.dart';


void backgroundMain() {
  WidgetsFlutterBinding.ensureInitialized();

  BackGroundService.instance().startCounting();
}


