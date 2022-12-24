import 'package:app_client/ui/controller_bloc.dart';
import 'package:app_client/ui/controller_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'controller_state.dart';

class MessageSwitcher extends StatelessWidget {
  final String title;
  final void Function(bool) onSwitchValueChange;
  final bool value;

  const MessageSwitcher(
      {super.key,
      required this.title,
      required this.onSwitchValueChange,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(
            value: value,
            onChanged: (val) {
              onSwitchValueChange(val);
            }),
      ],
    );
  }
}

class CrawlerControllerPage extends StatefulWidget {
  const CrawlerControllerPage({Key? key}) : super(key: key);

  @override
  State<CrawlerControllerPage> createState() => _CrawlerControllerPageState();
}

class _CrawlerControllerPageState extends State<CrawlerControllerPage> {
  final ControllerBloc _bloc = ControllerBloc();

  bool logSensorState = false;
  bool logStreamOriginalState = false;
  bool logStreamSegmentedState = false;
  bool logStreamOGState = false;

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
          child: BlocListener<ControllerBloc, ControllerState>(
            listener: (context, state) {
              if (state is LogSwitchSuccessState) {
                switch (state.logType) {
                  case LogType.sensors:
                    logSensorState = !logSensorState;
                    break;
                  case LogType.streamOriginal:
                    logStreamOriginalState = !logStreamOriginalState;
                    break;
                  case LogType.streamSegmented:
                    logStreamSegmentedState = !logStreamSegmentedState;
                    break;
                  case LogType.streamOG:
                    logStreamOGState = !logStreamOGState;
                    break;
                }
              }
            },
            child: BlocBuilder<ControllerBloc, ControllerState>(
                builder: (context, state) {
              return Stack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  //Expanded(child: RTCVideoView(RTCVideoRenderer())),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        MessageSwitcher(
                            title: "LOG sensors",
                            value: logSensorState,
                            onSwitchValueChange: (value) {
                              if (value) {
                                _bloc.startLoggingSensors();
                              } else {
                                _bloc.stopLoggingSensors();
                              }
                            }),
                        MessageSwitcher(
                            title: "LOG original image stream",
                            value: logStreamOriginalState,
                            onSwitchValueChange: (value) {
                              if (value) {
                                _bloc.startLoggingStreamOriginal();
                              } else {
                                _bloc.stopLoggingStreamOriginal();
                              }
                            }),
                        MessageSwitcher(
                            title: "LOG segmented image stream",
                            value: logStreamSegmentedState,
                            onSwitchValueChange: (value) {
                              if (value) {
                                _bloc.startLoggingStreamSegmented();
                              } else {
                                _bloc.stopLoggingStreamSegmented();
                              }
                            }),
                        MessageSwitcher(
                            title: "LOG occupancy grid image stream",
                            value: logStreamOGState,
                            onSwitchValueChange: (value) {
                              if (value) {
                                _bloc.startLoggingStreamOccupancyGrid();
                              } else {
                                _bloc.stopLoggingStreamOccupancyGrid();
                              }
                            }),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.8),
                    child: Joystick(
                      period: const Duration(milliseconds: 125),
                      mode: JoystickMode.all,
                      listener: (details) {
                        setState(() {
                          _bloc.add(RequestSpeedVectorChange(
                              80 * details.x, 100 * details.y));
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
