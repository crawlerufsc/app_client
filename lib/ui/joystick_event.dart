import 'package:equatable/equatable.dart';

class JoystickEvent extends Equatable {
  final int type;
  const JoystickEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class RequestSpeedIncreaseEvent extends JoystickEvent {
  const RequestSpeedIncreaseEvent() : super(1);
}

class RequestSpeedDecreaseEvent extends JoystickEvent {
  const RequestSpeedDecreaseEvent() : super(2);
}

class RequestTurnLeftEvent extends JoystickEvent {
  const RequestTurnLeftEvent() : super(3);
}

class RequestTurnRightEvent extends JoystickEvent {
  const RequestTurnRightEvent() : super(4);
}
