import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathUtil {
  static final PathUtil _instance = PathUtil();

  static PathUtil get instance => _instance;

  String documentsPath = '';
  String externalStoragePath = '';
  String appName = 'i2';

  Future<void> init(String appName) async {
    this.documentsPath = (await getApplicationDocumentsDirectory()).path;
    if (Platform.isAndroid) {
      this.externalStoragePath = (await getExternalStorageDirectory()).path;
    } else {
      this.externalStoragePath = this.documentsPath;
    }
    await getTemporaryDirectory();
    this.appName = appName;
  }

  // 获取存储目录
  String getAppStoragePath() {
    return Platform.isAndroid ? externalStoragePath : documentsPath;
  }

}
