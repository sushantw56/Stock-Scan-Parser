import "package:get/get.dart";
import 'package:stock_scan_parser/views/home_view.dart';

class AppRoutes {
  static const String home = "/home_view";
}

List<GetPage> listOfPages = [
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeView(),
    bindings: const [],
  ),
];
