import 'package:flame/components/position_component.dart';
import 'package:flame/sprite.dart';

import '../assets.dart';

import 'dart:ui';

class Background extends PositionComponent {
  Sprite _sprite;

  Background() {
    _sprite = Assets.background.getSprite('background');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _sprite.render(canvas);
  }

  @override
  final int priority = 1;
}
