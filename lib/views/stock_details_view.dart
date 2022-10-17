// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/stocks_data_model.dart';
import '../utils/routes.dart';

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
          ],
        ),
      ),
    );
  }
}

class CriteriaWidget extends StatelessWidget {
  CriteriaWidget({
    Key? key,
    required this.criteria,
  }) : super(key: key);

  final Criterion criteria;

  dynamic firstPassedArguments;

  List<TextSpan>? _textFunction(
      String text, String variable, String value, dynamic passedArguments) {
    if (text.contains(variable)) {
      List<TextSpan> children = [];
      String preVariableText = text.substring(0, text.indexOf(variable));
      if (preVariableText.isNotEmpty) {
        if (!preVariableText.contains('(')) {
          children.add(
            TextSpan(text: preVariableText),
          );
        } else {
          String prePreVariableText = text.substring(0, text.indexOf('('));
          String middleText =
              text.substring(text.indexOf(')') + 1, text.indexOf('\$'));
          children.add(TextSpan(text: prePreVariableText));
          children.add(
            TextSpan(
              text: text.substring(text.indexOf('('), text.indexOf(')') + 1),
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(
                    firstPassedArguments.runtimeType.toString() == 'ValueType'
                        ? AppRoutes.valueType
                        : AppRoutes.indicatorType,
                    arguments: firstPassedArguments,
                  );
                },
            ),
          );
          children.add(TextSpan(text: middleText));
        }
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
        firstPassedArguments ??= criteria.variable![element]['type'] == 'value'
            ? ValueType.fromJson(criteria.variable![element])
            : IndicatorType.fromJson(criteria.variable![element]);
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
