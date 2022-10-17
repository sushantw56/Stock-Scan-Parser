import 'dart:convert';
import 'package:http/http.dart' as http;

class StocksAPI {
  // Fetch Stocks Data
  Future<dynamic> getStocksData(http.Client http) async {
    final response = await http
        .get(Uri.parse("https://mobile-app-challenge.herokuapp.com/data"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
