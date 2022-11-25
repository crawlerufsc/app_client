import 'package:flutter/material.dart';

import 'ui/joystick_page.dart';

void main() {
  runApp(const CrawlerJoystickPageApp());
}

const ballSize = 20.0;
const step = 10.0;

class CrawlerJoystickPageApp extends StatelessWidget {
  const CrawlerJoystickPageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crawler Remote Controller'),
        ),
        body: const CrawlerJoystickPage(),
      ),
    );
  }
}

class Ball extends StatelessWidget {
  final double x;
  final double y;

  const Ball(this.x, this.y, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
        ),
      ),
    );
  }
}
