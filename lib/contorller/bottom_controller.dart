import 'package:get/get.dart';

class BottomController extends GetxController {
  var selectBottom = 0.obs;

  selectedMenu(int index) {
    selectBottom.value = index;
  }
}
