import '../utils/enum.dart';
import '../utils/http_service.dart';

class StocksAPI {
  HTTPHandler httpHandler = HTTPHandler();

  // Fetch Stocks Data
  Future<dynamic> getStocksData() async {
    var response = await httpHandler.httpRequest(
      url: "https://mobile-app-challenge.herokuapp.com/data",
      method: RequestType.get,
    );
    return response;
  }
}
