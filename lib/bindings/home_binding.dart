import 'package:get/get.dart';
import 'package:stock_scan_parser/controllers/stocks_controller.dart';

class StocksBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StocksController>(() => StocksController());
  }
}
