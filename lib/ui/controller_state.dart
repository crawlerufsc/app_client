import 'package:app_client/ui/controller_event.dart';
import 'package:equatable/equatable.dart';

abstract class ControllerState extends Equatable {
  const ControllerState();

  @override
  List<Object?> get props => [];
}

class ControllerInitState extends ControllerState {}

class ControllerLoadingState extends ControllerState {}

class ControllerSuccessState extends ControllerState {
  final int newX;
  final int newY;

  const ControllerSuccessState(this.newX, this.newY);
}

class ControllerErrorState extends ControllerState {
  final String? message;
  const ControllerErrorState(this.message);
}

class LogSwitchSuccessState extends ControllerState {
  final LogType logType;

  const LogSwitchSuccessState(this.logType);
}
