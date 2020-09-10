import 'package:dextraquario/fish_info.dart';
import 'package:flame/position.dart';
import 'package:flame/animation.dart';
import 'package:flame/text_config.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flutter/animation.dart' hide Animation;
import 'package:flutter/painting.dart';

import 'dart:ui';
import 'dart:math';

import '../assets.dart';
import '../dextra_quario.dart';

class Fish extends PositionComponent with HasGameRef<DextraQuario> {
  static const NORMAL_SPEED = 20.0;
  static const FISH_WIDTH = 48.0;
  static const FISH_HEIGHT = 32.0;

  static final _tween = Tween<double>(
    begin: 0.5,
    end: 2.5,
  );

  static final TextConfig _nameLabel = TextConfig(
    fontFamily: 'Roboto',
    fontSize: 6,
    color: Color(0x44FFFFFF),
    textAlign: TextAlign.center,
  );

  static final TextConfig _focusedNameLabel = TextConfig(
    fontFamily: 'Roboto',
    fontSize: 12,
    color: Color(0xFFFFFFFF),
    textAlign: TextAlign.center,
  );

  TextPainter _labelTp;
  TextPainter _focusedLabelTp;

  bool _runningForFood = false;
  Random _random = Random();
  Position _target;
  FishInfo fishInfo;
  Animation fishAnimation;
  double size;
  bool hasFocus = false;

  Fish({this.fishInfo, this.size}) {
    fishAnimation = Assets.fishes.getAnimation(fishInfo.fishColor);

    final label = "${fishInfo.name} (${fishInfo.fishItems.length})";
    _labelTp = _nameLabel.toTextPainter(label);
    _focusedLabelTp = _focusedNameLabel.toTextPainter(label);
  }

  void setTarget(Position target) {
    _target = target;
    _runningForFood = true;
  }

  @override
  void onMount() {
    final _scale = _tween.transform(size);
    width = (FISH_WIDTH * _scale).roundToDouble();
    height = (FISH_HEIGHT * _scale).roundToDouble();

    x = _random.nextDouble() * (DextraQuario.GAME_WIDTH - width);
    y = _random.nextDouble() * (DextraQuario.GAME_HEIGHT - height);

    _randomTarget();
  }

  void _randomTarget() {
    _target = Position(
      _random.nextDouble() * (DextraQuario.GAME_WIDTH - width),
      _random.nextDouble() * (DextraQuario.GAME_HEIGHT - height),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    fishAnimation.update(dt);

    hasFocus = gameRef.mousePos != null && toRect().contains(gameRef.mousePos);

    final _dir = _target.clone().minus(Position(x, y)).normalize();
    final _s = _dir.times((_runningForFood ? 10 : 1) * NORMAL_SPEED * dt);

    renderFlipX = _s.x > 0;

    x += _s.x;
    y += _s.y;

    if ((_s.x < 0 && _match(x, _target.x)) || (_s.x > 0 && _match(x + width, _target.x))) {
      if (_runningForFood) {
          _runningForFood = false;
      }

      _randomTarget();
    }

    if ((_s.y < 0 && _match(y, _target.y)) || (_s.y > 0 && _match(y + height, _target.y))) {
      if (_runningForFood) {
          _runningForFood = false;
      }
      _randomTarget();
    }
  }

  bool _match(double a, double b) {
    return (a - b).abs() <= 1;
  }

  @override
  void render(Canvas canvas) {
    final tp = hasFocus ? _focusedLabelTp : _labelTp;
    tp.paint(canvas, Offset(x + width / 2 - tp.width / 2, y - tp.height));

    prepareCanvas(canvas);
    fishAnimation.getSprite().render(canvas, width: width, height: height);
  }

  @override
  int priority() => 2;
}
