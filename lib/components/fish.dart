import 'package:dextraquario/fish_info.dart';
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

  Random _random = Random();
  Position _target;
  FishInfo fishInfo;

  Fish({this.fishInfo}) {
    width = FISH_WIDTH;
    height = FISH_HEIGHT;
  }

  @override
  void onMount() {
    _randomTarget();
  }

  void _randomTarget() {
    _target = Position(
      _random.nextDouble() * gameRef.size.width - FISH_WIDTH,
      _random.nextDouble() * gameRef.size.height - FISH_HEIGHT,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final _s = _target.clone().minus(Position(x, y)).normalize();

    x += _s.x;
    y += _s.y;

    if ((_s.x < 0 && x.round() == _target.x.round()) || (_s.x > 0 && x.round() + width == _target.x.round())) {
      _randomTarget();
    }

    if ((_s.y < 0 && y.round() == _target.y.round()) || (_s.y > 0 && y.round() + height == _target.y.round())) {
      _randomTarget();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(toRect(), BasicPalette.white.paint);
  }
}
