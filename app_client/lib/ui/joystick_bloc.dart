import 'package:app_client/repo/crawler_repository.dart';
import 'package:app_client/ui/joystick_event.dart';
import 'package:app_client/ui/joystick_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoystickBloc extends Bloc<JoystickEvent, JoystickState> {
  JoystickBloc() : super(JoystickInitState()) {
    on<RequestSpeedIncreaseEvent>((event, emit) async {
      try {
        emit(JoystickLoadingState());
        final result = await repository.requestSpeedIncrease();

        if (result.status) {
          emit(JoystickSuccessState());
        } else {
          emit(JoystickErrorState(result.error));
        }
      } on NetworkError {
        emit(const JoystickErrorState('Offline'));
      }
    });

    on<RequestSpeedDecreaseEvent>((event, emit) async {
      try {
        emit(JoystickLoadingState());
        final result = await repository.requestSpeedDecrease();

        if (result.status) {
          emit(JoystickSuccessState());
        } else {
          emit(JoystickErrorState(result.error));
        }
      } on NetworkError {
        emit(const JoystickErrorState('Offline'));
      }
    });

    on<RequestTurnLeftEvent>((event, emit) async {
      try {
        emit(JoystickLoadingState());
        final result = await repository.requestTurnLeft();

        if (result.status) {
          emit(JoystickSuccessState());
        } else {
          emit(JoystickErrorState(result.error));
        }
      } on NetworkError {
        emit(const JoystickErrorState('Offline'));
      }
    });

    on<RequestTurnRightEvent>((event, emit) async {
      try {
        emit(JoystickLoadingState());
        final result = await repository.requestTurnRight();

        if (result.status) {
          emit(JoystickSuccessState());
        } else {
          emit(JoystickErrorState(result.error));
        }
      } on NetworkError {
        emit(const JoystickErrorState('Offline'));
      }
    });
  }

  final CrawlerRepository repository = CrawlerRepository();
}
