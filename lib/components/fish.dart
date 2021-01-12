import 'package:dextraquario/fish_info.dart';
import 'package:flame/components/position_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flame/text_config.dart';
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
  Vector2 _target;
  FishInfo fishInfo;
  SpriteAnimation fishAnimation;
  double fishSize;
  bool hasFocus = false;

  Fish({this.fishInfo, this.fishSize}) {
    fishAnimation = Assets.fishes.getAnimation(fishInfo.fishColor);

    final label = "${fishInfo.name} (${fishInfo.fishItems.length})";
    _labelTp = _nameLabel.toTextPainter(label);
    _focusedLabelTp = _focusedNameLabel.toTextPainter(label);
  }

  Vector2 _trimTarget(Vector2 target) {
    final maxX = DextraQuario.GAME_WIDTH - width;
    final maxY = DextraQuario.GAME_HEIGHT - height;

    return Vector2(
      max(0.0, min(maxX, target.x)),
      max(0.0, min(maxY, target.y)),
    );
  }

  void setTarget(Vector2 target) {
    _target = _trimTarget(target);
    _runningForFood = true;
  }

  @override
  void onMount() {
    super.onMount();
    final _scale = _tween.transform(fishSize);
    width = (FISH_WIDTH * _scale).roundToDouble();
    height = (FISH_HEIGHT * _scale).roundToDouble();

    x = _random.nextDouble() * (DextraQuario.GAME_WIDTH - width);
    y = _random.nextDouble() * (DextraQuario.GAME_HEIGHT - height);

    _randomTarget();
  }

  void _randomTarget() {
    _target = Vector2(
      _random.nextDouble() * (DextraQuario.GAME_WIDTH - width),
      _random.nextDouble() * (DextraQuario.GAME_HEIGHT - height),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    fishAnimation.update(dt);

    hasFocus = gameRef.mousePos != null && toRect().contains(gameRef.mousePos);

    final _dir = (_target.clone() - Vector2(x, y)).normalized();
    final _s = _dir * ((_runningForFood ? 10 : 1) * NORMAL_SPEED * dt);

    renderFlipX = _s.x > 0;

    x += _s.x;
    y += _s.y;

    if ((_s.x < 0 && _match(x, _target.x)) ||
        (_s.x > 0 && _match(x + width, _target.x))) {
      if (_runningForFood) {
        _runningForFood = false;
      }

      _randomTarget();
    }

    if ((_s.y < 0 && _match(y, _target.y)) ||
        (_s.y > 0 && _match(y + height, _target.y))) {
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

    super.render(canvas);
    fishAnimation.getSprite().render(canvas, size: size);
  }

  @override
  final int priority = 2;
}
