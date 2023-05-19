import 'package:get/get.dart';

import '../models/models.dart';

class ProductDetailController extends GetxController {
  late Product product;
  final List<int> _colorList = [];
  final List<String> _sizeList = [];
  final Rx<int> selectedColor = 0.obs;
  final Rx<String> selectedSize = ''.obs;
  final Rx<int> selectedQuantity = 1.obs;
  final Rx<double> cost = 0.0.obs;
  final RxBool enableButton = false.obs;

  List<int> get colorList => _colorList;
  List<String> get sizeList => _sizeList;


  void updateProduct(Product product) {
    this.product = product;
    selectedSize.value = "";
    selectedColor.value = 0;
    selectedQuantity.value = 1;
    cost.value = product.price * selectedQuantity.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _colorList.addAll([
      0xff29695D,
      0xff5B8EA3,
      0xff746A36,
      0xff2E2E2E
    ]);
    _sizeList.addAll(["39", "40", "41", "42", "43", "44", "45"]);

    ever(selectedColor, (callback) => {
      enableButton.value = _validateFields()
    });

    ever(selectedSize, (callback) => {
      enableButton.value = _validateFields()
    });

    ever(selectedQuantity, (callback) => {
      cost.value = double.parse(((selectedQuantity * 1.0) * product.price).toStringAsFixed(2))
    });

    super.onInit();
  }

  bool _validateFields() {
    return selectedColor.value != 0 && selectedSize.value.trim().isNotEmpty;
  }

  @override
  void onClose() {
    // Reset all variables when the controller is closed
    selectedSize.value = "";
    selectedColor.value = 0;
    selectedQuantity.value = 1;
    super.onClose();
  }
}