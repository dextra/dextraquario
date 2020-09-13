import 'package:flame/components/component.dart';
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
    _sprite.render(canvas);
  }

  @override
  int priority() => 1;
}
