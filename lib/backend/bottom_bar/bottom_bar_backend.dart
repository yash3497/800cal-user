import 'package:get/get.dart';

class BottomBarBackend extends GetxController {
  int gIndex = 0;

  void updateIndex(int index) {
    gIndex = index;
    update();
  }
}
