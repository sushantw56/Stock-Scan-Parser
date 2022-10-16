import 'package:get/get.dart';
import 'package:stock_scan_parser/api/stocks_api.dart';

import '../models/stocks_data_model.dart';

class StocksController extends GetxController {
  var isLoading = false.obs;
  var stocksList = <StocksDataModel>[].obs;
  var stocksData = [].obs;

  @override
  void onInit() {
    getStocksData();
    super.onInit();
  }

  getStocksData() async {
    try {
      isLoading(true);
      stocksList.clear();
      var data = await StocksAPI().getStocksData();
      if (data != null) {
        for (var element in data) {
          stocksList.add(StocksDataModel.fromJson(element));
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
