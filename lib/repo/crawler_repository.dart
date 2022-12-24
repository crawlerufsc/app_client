import 'package:dio/dio.dart';

import '../model/command_req_response.dart';

class CrawlerRepository {
  final String ip = "http://10.42.0.1:5000";
  final Dio _dio = Dio();
  int lastAngle = 0;
  int lastAccel = 0;

  CrawlerRepository();

  Future<CommandReqResponse> requestCommand(
      String cmd, int appliedValue) async {
    try {
      final response = await _dio.get("$ip$cmd");
      return CommandReqResponse(response.statusCode == 200, appliedValue);
    } catch (error, stacktrace) {
      return CommandReqResponse.withError(
          "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<CommandReqResponse> requestPostCommand(String cmd) async {
    try {
      final response = await _dio.post<String>("$ip$cmd");
      return CommandReqResponse(response.statusCode == 200, 0);
    } catch (error, stacktrace) {
      return CommandReqResponse.withError(
          "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<CommandReqResponse> requestDeleteCommand(String cmd) async {
    try {
      final response = await _dio.delete<String>("$ip$cmd");
      return CommandReqResponse(response.statusCode == 200, 0);
    } catch (error, stacktrace) {
      return CommandReqResponse.withError(
          "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<CommandReqResponse> requestSetAngle(double angle) {
    if (angle > 40) {
      angle = 40;
    }
    if (angle < -40) {
      angle = -40;
    }

    bool right = angle >= 0;

    int applyAngle = (angle.abs() - (angle.abs() % 10)).round();

    // if (lastAngle == applyAngle) {
    //   return Future.delayed(
    //       Duration.zero, () => CommandReqResponse(true, lastAngle));
    // }

    if (right) {
      return requestCommand("/turn/right/$applyAngle", applyAngle);
    } else {
      return requestCommand("/turn/left/$applyAngle", applyAngle);
    }
  }

  Future<CommandReqResponse> requestSetSpeed(double accel) {
    if (accel > 250) {
      accel = 250;
    }
    if (accel < -250) {
      accel = -250;
    }

    bool forward = accel >= 0;

    int applyAccel = (accel.abs() - (accel.abs() % 10)).round();

    // if (lastAccel == accel) {
    //   return Future.delayed(
    //       Duration.zero, () => CommandReqResponse(true, lastAccel));
    // }

    if (forward) {
      return requestCommand("/speed/forward/$applyAccel", applyAccel);
    } else {
      return requestCommand("/speed/backward/$applyAccel", applyAccel);
    }
  }

  Future<CommandReqResponse> requestSpeedIncrease() {
    return requestCommand("/speed/inc", 0);
  }

  Future<CommandReqResponse> requestSpeedDecrease() {
    return requestCommand("/speed/dec", 0);
  }

  Future<CommandReqResponse> requestTurnRight() {
    return requestCommand("/turn/right", 0);
  }

  Future<CommandReqResponse> requestTurnLeft() {
    return requestCommand("/turn/left", 0);
  }

  Future<CommandReqResponse> requestStartLoggingSensors() {
    return requestPostCommand("/logging/sensors");
  }

  Future<CommandReqResponse> requestStopLoggingSensors() {
    return requestDeleteCommand("/logging/sensors");
  }

  Future<CommandReqResponse> requestStartLoggingStreamOriginal() {
    return requestPostCommand("/logging/vision/original");
  }

  Future<CommandReqResponse> requestStopLoggingStreamOriginal() {
    return requestDeleteCommand("/logging/vision/original");
  }

  Future<CommandReqResponse> requestStartLoggingStreamSegmented() {
    return requestPostCommand("/logging/vision/segmented");
  }

  Future<CommandReqResponse> requestStopLoggingStreamSegmented() {
    return requestDeleteCommand("/logging/vision/segmented");
  }

  Future<CommandReqResponse> requestStartLoggingStreamOccupancyGrid() {
    return requestPostCommand("/logging/vision/og");
  }

  Future<CommandReqResponse> requestStopLoggingStreamOccupancyGrid() {
    return requestDeleteCommand("/logging/vision/og");
  }
}

class NetworkError extends Error {}
