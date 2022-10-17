import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_scan_parser/api/stocks_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group('getStocksData', () {
    test('returns stocks data when http response is successful', () async {
      // Mock the API call to return a json response with http status 200 Ok
      final mockHTTPClient = MockClient((request) async {
        // Create sample response of the HTTP call
        final response = [
          {
            "id": 1,
            "name": "Top gainers",
            "tag": "Intraday Bullish",
            "color": "green",
            "criteria": [
              {
                "type": "plain_text",
                "text": "Sort - %price change in descending order"
              }
            ]
          }
        ];
        return Response(jsonEncode(response), 200);
      });
      // Check whether getStocksData function returns
      // stocks data which will be a List<dynamic>
      expect(await StocksAPI().getStocksData(mockHTTPClient),
          isA<List<dynamic>>());
    });

    test('return error message when http response is unsuccessful', () async {
      // Mock the API call to return an
      // null json response with http status 404
      final mockHTTPClient = MockClient((request) async {
        const response = null;
        return Response(jsonEncode(response), 404);
      });
      expect(await StocksAPI().getStocksData(mockHTTPClient), null);
    });
  });
}
