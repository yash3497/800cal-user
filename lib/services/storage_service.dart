import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();

  void write(String key, dynamic value) {
    box.write(key, value);
  }

  dynamic read(String key) async {
    return await box.read(key);
  }
}
