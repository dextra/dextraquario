import 'package:flame/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';

import 'dart:ui';
import 'dart:math';

import './components/background.dart';
import './components/foreground.dart';
import './components/fish.dart';

import './overlays/fish_overlay.dart';

class DextraQuario extends BaseGame with HasWidgetsOverlay, TapDetector {
  static const GAME_WIDTH = 320;
  static const GAME_HEIGHT = 320;

  double _scaleFactor;
  Position _translateFactor;

  DextraQuario(Size screenSize) {
    this.size = screenSize;
    _calcScaleFactor();

    add(Background());
    add(Foreground());
  }

  void _calcScaleFactor() {
    // We can use either width or height since the resolution is a square one
    final _scaleRaw = (min(size.width, size.height) / GAME_WIDTH);
    _scaleFactor = _scaleRaw - _scaleRaw % 0.02;

    final _finalWidth = _scaleFactor * GAME_WIDTH;
    final _finalHeight = _scaleFactor * GAME_HEIGHT;

    _translateFactor = Position(
        size.width / 2 - _finalWidth / 2,
        size.height / 2 - _finalHeight / 2,
    );
  }

  @override
  void resize(Size size) {
    super.resize(size);

    _calcScaleFactor();
  }

  @override
  void render(Canvas canvas) {
    canvas.translate(_translateFactor.x, _translateFactor.y);
    canvas.scale(_scaleFactor);
    super.render(canvas);
  }

  @override
  void onTapUp(details) {

    final projectedOffset = Offset(
        (details.localPosition.dx - _translateFactor.x) / _scaleFactor,
        (details.localPosition.dy - _translateFactor.y) / _scaleFactor,
    );

    final fish = components
        .where((c) => c is Fish)
        .cast<Fish>()
        .firstWhere(
            (o) => o.toRect().contains(projectedOffset),
            orElse: () => null,
        );

    if (fish != null) {
      addWidgetOverlay(
          'fishOverlay',
          FishOverlay(
              fishInfo: fish.fishInfo,
              onCloseInfo: () => removeWidgetOverlay('fishOverlay'),
          ));
    }
  }
}
