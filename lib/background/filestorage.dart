import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  FileStorage() {
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/log.txt');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print("$e NAME2");
      // FlutterLogs.logError("Read Error", "subTag", e.toString());
      return e.toString();
    }
  }

  Future<File?> write(String content) async {
    try {
      final file = await _localFile;
      return file.writeAsString(content, mode: FileMode.append);
    } catch (e) {
      print("$e NAME");
      // FlutterLogs.logError("Read Error", "subTag", e.toString());
      return null;
    }
  }
}
