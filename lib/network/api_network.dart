import 'package:dio/dio.dart';

final dio = Dio();

class ApiNetwork {
  final String key = 'AIzaSyCBx6fwafrrtcQdZUiq3pzkr2oFYnQwoUI';

  Future<dynamic> getLocation() async {
    final response = await dio.get(
      "https://api.coindesk.com/v1/bpi/currentprice.json",
    );
    print(dio.options.baseUrl);
    print('Response: ${response}');
    return response;
  }
}
