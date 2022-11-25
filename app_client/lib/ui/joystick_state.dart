import 'package:equatable/equatable.dart';

abstract class JoystickState extends Equatable {
  const JoystickState();

  @override
  List<Object?> get props => [];
}

class JoystickInitState extends JoystickState {}

class JoystickLoadingState extends JoystickState {}

class JoystickSuccessState extends JoystickState {}

class JoystickErrorState extends JoystickState {
  final String? message;
  const JoystickErrorState(this.message);
}
