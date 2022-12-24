import 'package:app_client/model/command_req_response.dart';
import 'package:app_client/repo/crawler_repository.dart';
import 'package:app_client/ui/controller_event.dart';
import 'package:app_client/ui/controller_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  ControllerBloc() : super(ControllerInitState()) {
    on<RequestSpeedVectorChange>((event, emit) async {
      try {
        emit(ControllerLoadingState());

        final result1 = await repository.requestSetAngle(event.x);

        if (result1.status) {
          final result2 = await repository.requestSetSpeed(event.y);

          if (result2.status) {
            emit(ControllerSuccessState(
                result1.appliedValue, result2.appliedValue));
          } else {
            emit(ControllerErrorState(result2.error));
          }
        } else {
          emit(ControllerErrorState(result1.error));
        }
      } on NetworkError {
        emit(const ControllerErrorState('Offline'));
      }
    });

    on<RequestSpeedIncreaseEvent>((event, emit) async {
      try {
        emit(ControllerLoadingState());
        final result = await repository.requestSpeedIncrease();

        if (result.status) {
          emit(ControllerSuccessState(0, result.appliedValue));
        } else {
          emit(ControllerErrorState(result.error));
        }
      } on NetworkError {
        emit(const ControllerErrorState('Offline'));
      }
    });

    on<RequestSpeedDecreaseEvent>((event, emit) async {
      try {
        emit(ControllerLoadingState());
        final result = await repository.requestSpeedDecrease();

        if (result.status) {
          emit(ControllerSuccessState(0, result.appliedValue));
        } else {
          emit(ControllerErrorState(result.error));
        }
      } on NetworkError {
        emit(const ControllerErrorState('Offline'));
      }
    });

    on<RequestTurnLeftEvent>((event, emit) async {
      try {
        emit(ControllerLoadingState());
        final result = await repository.requestTurnLeft();

        if (result.status) {
          emit(ControllerSuccessState(result.appliedValue, 0));
        } else {
          emit(ControllerErrorState(result.error));
        }
      } on NetworkError {
        emit(const ControllerErrorState('Offline'));
      }
    });

    on<RequestTurnRightEvent>((event, emit) async {
      try {
        emit(ControllerLoadingState());
        final result = await repository.requestTurnRight();

        if (result.status) {
          emit(ControllerSuccessState(result.appliedValue, 0));
        } else {
          emit(ControllerErrorState(result.error));
        }
      } on NetworkError {
        emit(const ControllerErrorState('Offline'));
      }
    });

    on<RequestLogEvent>(
      (event, emit) async {
        emit(ControllerLoadingState());

        CommandReqResponse? resp;

        switch (event.logType) {
          case LogType.sensors:
            if (event.value) {
              resp = await repository.requestStartLoggingSensors();
            } else {
              resp = await repository.requestStopLoggingSensors();
            }
            if (resp.status) {
              emit(const LogSwitchSuccessState(LogType.sensors));
            }

            break;
          case LogType.streamOriginal:
            if (event.value) {
              resp = await repository.requestStartLoggingStreamOriginal();
            } else {
              resp = await repository.requestStopLoggingStreamOriginal();
            }
            if (resp.status) {
              emit(const LogSwitchSuccessState(LogType.streamOriginal));
            }
            break;
          case LogType.streamSegmented:
            if (event.value) {
              resp = await repository.requestStartLoggingStreamSegmented();
            } else {
              resp = await repository.requestStopLoggingStreamSegmented();
            }
            if (resp.status) {
              emit(const LogSwitchSuccessState(LogType.streamSegmented));
            }
            break;
          case LogType.streamOG:
            if (event.value) {
              resp = await repository.requestStartLoggingStreamOccupancyGrid();
            } else {
              resp = await repository.requestStopLoggingStreamOccupancyGrid();
            }
            if (resp.status) {
              emit(const LogSwitchSuccessState(LogType.streamOG));
            }
            break;
        }
      },
    );
  }

  final CrawlerRepository repository = CrawlerRepository();

  void startLoggingSensors() {
    add(const RequestLogEvent(logType: LogType.sensors, value: true));
  }

  void stopLoggingSensors() {
    add(const RequestLogEvent(logType: LogType.sensors, value: false));
  }

  void startLoggingStreamOriginal() {
    add(const RequestLogEvent(logType: LogType.streamOriginal, value: true));
  }

  void stopLoggingStreamOriginal() {
    add(const RequestLogEvent(logType: LogType.streamOriginal, value: false));
  }

  void startLoggingStreamSegmented() {
    add(const RequestLogEvent(logType: LogType.streamSegmented, value: true));
  }

  void stopLoggingStreamSegmented() {
    add(const RequestLogEvent(logType: LogType.streamSegmented, value: false));
  }

  void startLoggingStreamOccupancyGrid() {
    add(const RequestLogEvent(logType: LogType.streamOG, value: true));
  }

  void stopLoggingStreamOccupancyGrid() {
    add(const RequestLogEvent(logType: LogType.streamOG, value: false));
  }
}
