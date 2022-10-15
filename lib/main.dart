import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/utils/theme.dart';

import 'utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]) //this is to setup device orientation of the app
      .then((_) {
    runApp(const Root());
  });
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRoutes.home,
      getPages: listOfPages,
      theme: customTheme(),
      home: const Scaffold(),
    );
  }
}
