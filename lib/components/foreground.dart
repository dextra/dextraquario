import 'package:flame/components/position_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/sprite.dart';

import '../assets.dart';

import 'dart:ui';

class Foreground extends PositionComponent {
  Sprite _sprite;
  final _postion = Vector2(0, 294);

  Foreground() {
    _sprite = Assets.background.getSprite('front');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _sprite.render(canvas, position: _postion);
  }

  @override
  final int priority = 3;
}
