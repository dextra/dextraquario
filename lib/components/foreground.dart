import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

import '../assets.dart';

import 'dart:ui';

class Foreground extends PositionComponent {
  Sprite _sprite;
  final _postion = Position(0, 294);

  Foreground() {
    _sprite = Assets.background.getSprite('front');
  }

  @override
  void render(Canvas canvas) {
    _sprite.renderPosition(canvas, _postion);
  }

  @override
  int priority() => 3;
}
