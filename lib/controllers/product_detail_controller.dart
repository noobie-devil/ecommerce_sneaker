import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  List<String> _colorList = [];
  List<String> _sizeList = [];
  var selectedColor = ''.obs;
  var selectedSize = ''.obs;
  var selectedQuantity = 1.obs;


  @override
  void onClose() {
    // Reset all variables when the controller is closed
    _colorList = [];
    _sizeList = [];
    selectedSize.value = "";
    selectedColor.value = "";
    selectedQuantity.value = 1;
    super.onClose();
  }
}