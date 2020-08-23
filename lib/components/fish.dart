import 'package:dextraquario/fish_info.dart';
import 'package:flame/position.dart';
import 'package:flame/animation.dart';
import 'package:flame/text_config.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';
import 'dart:math';

import '../assets.dart';
import '../dextra_quario.dart';

class Fish extends PositionComponent with HasGameRef<DextraQuario> {
  static const NORMAL_SPEED = 50.0;
  static const FISH_WIDTH = 180.0;
  static const FISH_HEIGHT = 90.0;

  static final TextConfig _nameLabel = TextConfig(
      fontFamily: 'Roboto',
      fontSize: 12,
      color: Color(0xFFFFFFFF),
      textAlign: TextAlign.center,
  );

  Random _random = Random();
  Position _target;
  FishInfo fishInfo;
  Animation fishAnimation;

  Fish({this.fishInfo}) {
    width = FISH_WIDTH;
    height = FISH_HEIGHT;

    fishAnimation = Assets.fishes.getAnimation(fishInfo.fishColor);
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
    fishAnimation.update(dt);

    final _s = _target.clone().minus(Position(x, y)).normalize();

    renderFlipX = _s.x > 0;

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
    final tp = _nameLabel.toTextPainter("${fishInfo.name}");
    tp.paint(canvas, Offset(x + width / 2 - tp.width / 2, y - 10));
    prepareCanvas(canvas);
    fishAnimation.getSprite().render(canvas, width: width, height: height);
  }
}
