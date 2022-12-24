import 'package:equatable/equatable.dart';

enum LogType {
  sensors,
  streamOriginal,
  streamSegmented,
  streamOG,
}

class ControllerEvent extends Equatable {
  final int type;
  const ControllerEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class RequestSpeedVectorChange extends ControllerEvent {
  final double x;
  final double y;
  const RequestSpeedVectorChange(this.x, this.y) : super(5);
}

class RequestSpeedIncreaseEvent extends ControllerEvent {
  const RequestSpeedIncreaseEvent() : super(1);
}

class RequestSpeedDecreaseEvent extends ControllerEvent {
  const RequestSpeedDecreaseEvent() : super(2);
}

class RequestTurnLeftEvent extends ControllerEvent {
  const RequestTurnLeftEvent() : super(3);
}

class RequestTurnRightEvent extends ControllerEvent {
  const RequestTurnRightEvent() : super(4);
}

class RequestLogEvent extends ControllerEvent {
  final LogType logType;
  final bool value;
  const RequestLogEvent({required this.logType, required this.value})
      : super(5);
}
