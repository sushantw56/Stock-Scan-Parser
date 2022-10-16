import "package:get/get.dart";
import 'package:stock_scan_parser/bindings/home_binding.dart';
import 'package:stock_scan_parser/views/home_view.dart';
import 'package:stock_scan_parser/views/indicator_type_view.dart';
import 'package:stock_scan_parser/views/stock_details_view.dart';
import 'package:stock_scan_parser/views/value_type_view.dart';

class AppRoutes {
  static const String home = "/home_view";
  static const String stockDetails = "/stock_details";
  static const String valueType = "/value_type";
  static const String indicatorType = "/indicator_type";
}

List<GetPage> listOfPages = [
  GetPage(
    name: AppRoutes.home,
    page: () => HomeView(),
    bindings: [
      StocksBindings(),
    ],
  ),
  GetPage(
    name: AppRoutes.stockDetails,
    page: () => StockDetailsView(),
  ),
  GetPage(
    name: AppRoutes.valueType,
    page: () => ValueTypeView(),
  ),
  GetPage(
    name: AppRoutes.indicatorType,
    page: () => IndicatorTypeView(),
  ),
];
