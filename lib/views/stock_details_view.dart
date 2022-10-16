import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/utils/routes.dart';

import '../models/stocks_data_model.dart';

class StockDetailsView extends StatelessWidget {
  StockDetailsView({super.key});

  final StocksDataModel stock = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              tileColor: const Color.fromRGBO(23, 134, 176, 1),
              title: Text(
                stock.name!,
                textScaleFactor: 1.0,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                stock.tag!,
                style: TextStyle(
                  color: stock.color == 'red' ? Colors.red : Colors.green,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stock.criteria!.length,
                itemBuilder: (context, index) {
                  return index == stock.criteria!.length - 1
                      ? CriteriaWidget(
                          criteria: stock.criteria![index],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CriteriaWidget(
                              criteria: stock.criteria![index],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'and',
                              textScaleFactor: 0.9,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                },
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: stock.criteria!
            //       .map(
            //         (criteria) => CriteriaWidget(
            //           criteria: criteria,
            //         ),
            //       )
            //       .toList(),
            // ),
          ],
        ),
      ),
    );
  }
}

class CriteriaWidget extends StatelessWidget {
  const CriteriaWidget({
    Key? key,
    required this.criteria,
  }) : super(key: key);

  final Criterion criteria;

  List<TextSpan>? _textFunction(
      String text, String variable, String value, dynamic passedArguments) {
    if (text.contains(variable)) {
      List<TextSpan> children = [];
      String preVariableText = text.substring(0, text.indexOf(variable));
      if (preVariableText.isNotEmpty) {
        children.add(
          TextSpan(text: preVariableText),
        );
      }
      children.add(
        TextSpan(
          text: '($value)',
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // print(arguments.runtimeType);
              Get.toNamed(
                passedArguments.runtimeType.toString() == 'ValueType'
                    ? AppRoutes.valueType
                    : AppRoutes.indicatorType,
                arguments: passedArguments,
              );
            },
        ),
      );
      String postVariableText = text
          .substring(text.indexOf(variable) + variable.length, text.length)
          .trimRight();
      if (postVariableText.isNotEmpty) {
        children.add(
          TextSpan(text: postVariableText),
        );
      }
      return children;
    }
    return [TextSpan(text: text)];
  }

  @override
  Widget build(BuildContext context) {
    if (criteria.type == 'plain_text') {
      return Text(
        criteria.text!,
      );
    } else if (criteria.type == 'variable') {
      var keys = criteria.variable!.keys;
      if (kDebugMode) {
        print(keys.toString());
      }
      List<TextSpan>? texts = [];
      String textAfterFirstVariable = criteria.text!;
      for (var element in keys) {
        if (criteria.text != textAfterFirstVariable) {
          texts = _textFunction(
              textAfterFirstVariable,
              element,
              criteria.variable![element]['type'] == 'value'
                  ? criteria.variable![element]['values'][0].toString()
                  : criteria.variable![element]['default_value'].toString(),
              criteria.variable![element]['type'] == 'value'
                  ? ValueType.fromJson(criteria.variable![element])
                  : IndicatorType.fromJson(criteria.variable![element]));
        } else {
          texts = _textFunction(
              criteria.text!,
              element,
              criteria.variable![element]['type'] == 'value'
                  ? criteria.variable![element]['values'][0].toString()
                  : criteria.variable![element]['default_value'].toString(),
              criteria.variable![element]['type'] == 'value'
                  ? ValueType.fromJson(criteria.variable![element])
                  : IndicatorType.fromJson(criteria.variable![element]));
        }
        textAfterFirstVariable =
            texts!.fold('', (prev, curr) => '$prev ${curr.text!}');
      }
      return RichText(
          text: TextSpan(
        children: texts,
      ));
    } else {
      return const Text('Something Went Wrong!!');
    }
  }
}
