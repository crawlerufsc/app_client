import 'package:dio/dio.dart';

import '../model/command_req_response.dart';

class CrawlerRepository {
  final String ip = "http://10.0.0.59:5000";
  final Dio _dio = Dio();

  CrawlerRepository();

  Future<CommandReqResponse> requestCommand(String cmd) async {
    try {
      final response = await _dio.get("$ip$cmd");
      return CommandReqResponse(response.statusCode == 200);
    } catch (error, stacktrace) {
      return CommandReqResponse.withError(
          "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<CommandReqResponse> requestSpeedIncrease() {
    return requestCommand("/speed/inc");
  }

  Future<CommandReqResponse> requestSpeedDecrease() {
    return requestCommand("/speed/dec");
  }

  Future<CommandReqResponse> requestTurnRight() {
    return requestCommand("/turn/right");
  }

  Future<CommandReqResponse> requestTurnLeft() {
    return requestCommand("/turn/left");
  }
}

class NetworkError extends Error {}
