import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';

import '../assets.dart';

import 'dart:ui';
import 'dart:math';


Random _random = Random();

class Bubble {

  static const SPEED = 3.5;

  Position pos = Position.empty();

  double yDistance = 30;
  double xDistance = 0;
  int xDir = 1;
  double size;

  Bubble() {
    yDistance = 80 + _random.nextDouble() * 40;
    _generateXDistance();

    size = 2.5 + _random.nextDouble() * 2.5;
  }

  void _generateXDistance() {
    xDistance = _random.nextDouble() * 5;
    xDir = _random.nextBool() ? 1 : -1;
  }

  void render(Canvas canvas) {
    Assets.bubble.renderRect(canvas, Rect.fromLTWH(pos.x, pos.y, size, size));
  }

  void update(double dt) {
    final ammount = SPEED * dt;
    pos.y -= ammount;
    yDistance -= ammount;

    pos.x -= ammount * xDir;
    xDistance -= ammount;

    if (xDistance <= 0) {
      _generateXDistance();
    }
  }

  bool expired() => yDistance <= 0;
}

class BubbleSource extends PositionComponent {

  List<Bubble> _bubbles = [];
  Timer _timer;

  void _emmit() {
    _bubbles.add(
        Bubble()
        ..xDistance = 2
        ..yDistance = 20
    );
  }

  BubbleSource() {
    _timer = Timer(1.5, repeat: true, callback: _emmit)..start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
    _bubbles.removeWhere((b) => b.expired());
    _bubbles.forEach((b) => b.update(dt));

  }

  @override
  void render(Canvas canvas) {
    prepareCanvas(canvas);
    _bubbles.forEach((b) => b.render(canvas));
  }

  @override
  int priority() => 4;
}
