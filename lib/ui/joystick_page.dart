import 'package:app_client/ui/joystick_bloc.dart';
import 'package:app_client/ui/joystick_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

import 'joystick_state.dart';

class CrawlerJoystickPage extends StatefulWidget {
  const CrawlerJoystickPage({Key? key}) : super(key: key);

  @override
  State<CrawlerJoystickPage> createState() => _CrawlerJoystickPageState();
}

class _CrawlerJoystickPageState extends State<CrawlerJoystickPage> {
  double _x = 100;
  double _y = 100;

  final JoystickBloc _bloc = JoystickBloc();

  @override
  void initState() {
    //_bloc.add(Event?());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _bloc,
          child: BlocListener<JoystickBloc, JoystickState>(
            listener: (context, state) {
              if (state is JoystickErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<JoystickBloc, JoystickState>(
                builder: (context, state) {
              return Stack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  //Ball(_x, _y),
                  Align(
                    alignment: const Alignment(0, 0.8),
                    child: Joystick(
                      period: const Duration(milliseconds: 125),
                      mode: JoystickMode.all,
                      listener: (details) {
                        setState(() {
                          if (details.y > 0.7) {
                            _bloc.add(const RequestSpeedIncreaseEvent());
                          } else if (details.y < -0.7) {
                            _bloc.add(const RequestSpeedDecreaseEvent());
                          }
                          if (details.x > 0.7) {
                            _bloc.add(const RequestTurnRightEvent());
                          } else if (details.x < -0.7) {
                            _bloc.add(const RequestTurnLeftEvent());
                          }
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
