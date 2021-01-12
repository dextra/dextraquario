import 'package:flame/components/position_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/timer.dart';

import '../assets.dart';

import 'dart:ui';
import 'dart:math';

Random _random = Random();

class Bubble {
  static const SPEED = 3.5;

  Vector2 pos = Vector2.zero();

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
    Assets.bubble.render(
        canvas,
        position: pos,
        size: Vector2.all(size),
    );
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
    _bubbles.add(Bubble()
      ..xDistance = 2
      ..yDistance = 20);
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
    super.render(canvas);
    _bubbles.forEach((b) => b.render(canvas));
  }

  @override
  final int priority = 4;
}
