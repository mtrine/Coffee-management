
import 'package:get/get.dart';
import '../../../models/orderDetail.dart';

class CountControllerState extends GetxController {
  late final OrderDetail productOrder;
  RxInt itemCount = 0.obs;

  CountControllerState(this.productOrder);

  @override
  void onInit() {
    super.onInit();
    itemCount.value = productOrder.quantity;
  }

  void incrementCounter() {
    productOrder.quantity++;
    itemCount.value = productOrder.quantity;
  }

  void decrementCounter() {
    if (productOrder.quantity > 0) {
      productOrder.quantity--;
      itemCount.value = productOrder.quantity;
    }
  }
}