import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/models/stocks_data_model.dart';

class IndicatorTypeView extends StatelessWidget {
  IndicatorTypeView({super.key});

  IndicatorType indicatorData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final TextEditingController periodEditingController =
        TextEditingController(text: indicatorData.defaultValue.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(indicatorData.studyType!.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Parametes',
              textScaleFactor: 1.2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 80,
              width: Get.width,
              color: Colors.white,
              padding: const EdgeInsets.all(
                10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      indicatorData.parameterName!,
                      textScaleFactor: 1.1,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: periodEditingController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
