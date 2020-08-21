import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';
import 'dart:math';

import '../dextra_quario.dart';

class Fish extends PositionComponent with HasGameRef<DextraQuario> {
  static const NORMAL_SPEED = 50.0;
  static const FISH_WIDTH = 100.0;
  static const FISH_HEIGHT = 50.0;

  Position _direction = Position.empty();
  Random _random = Random();

  Fish() {
    width = FISH_WIDTH;
    height = FISH_HEIGHT;

    _initialDirection();
  }

  double _randomDirectionValue() {
    return _random.nextBool() ? 1 : -1;
  }

  void _initialDirection() {
    _direction = Position(
        _randomDirectionValue(),
        _randomDirectionValue(),
    );
  }

  double _invert(double value) {
    return value > 0 ? -1 : 1;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final _s = _direction.clone().times(NORMAL_SPEED * dt);

    x += _s.x;
    y += _s.y;

    if (
        (_direction.x < 0 && x <= 0) ||
        (_direction.x > 0 && x + width >= gameRef.size.width)
    ) {
      _direction.x = _invert(_direction.x);
    }

    if (
        (_direction.y < 0 && y <= 0) ||
        (_direction.y > 0 && y + height >= gameRef.size.height)) {
      _direction.y = _invert(_direction.y);
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(toRect(), BasicPalette.white.paint);
  }
}
