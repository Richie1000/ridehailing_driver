import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponse {
  final int statusCode;
  final dynamic data;
  final String? error;

  ApiResponse({required this.statusCode, this.data, this.error});
}

class RequestUtils {
  static Future<ApiResponse> receiveRequest(String url) async {
    try {
      http.Response httpResponse = await http.get(Uri.parse(url));
      if (httpResponse.statusCode == 200) {
        return ApiResponse(
          statusCode: 200,
          data: jsonDecode(httpResponse.body),
        );
      } else {
        return ApiResponse(
          statusCode: httpResponse.statusCode,
          error: "Failed to load data",
        );
      }
    } catch (e) {
      return ApiResponse(
        statusCode: 500,
        error: 'Error occurred: ${e.toString()}',
      );
    }
  }
}
