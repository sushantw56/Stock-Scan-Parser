import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/models/stocks_data_model.dart';

import '../utils/dotted_divider.dart';

class ValueTypeView extends StatelessWidget {
  ValueTypeView({super.key});

  final ValueType valueData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2,
            ),
            child: DottedDivider(),
          ),
          itemCount: valueData.values!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(valueData.values![index].toString()),
            );
          },
        ),
      ),
    );
  }
}
