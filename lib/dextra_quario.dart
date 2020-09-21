import 'package:flame/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';

import 'dart:ui';
import 'dart:math';

import './fish_info.dart';
import './components/background.dart';
import './components/foreground.dart';
import './components/fish.dart';
import './components/bubble_source.dart';

import './overlays/fish_overlay.dart';

class DextraQuario extends BaseGame with HasWidgetsOverlay, TapDetector {
  static const GAME_WIDTH = 320;
  static const GAME_HEIGHT = 320;

  double _scaleFactor;
  Position _translateFactor;

  Offset mousePos;

  DextraQuario(Size screenSize) {
    this.size = screenSize;
    _calcScaleFactor();

    add(Background());
    add(Foreground());
    add(BubbleSource()
      ..x = 90
      ..y = 300);
    add(BubbleSource()
      ..x = 275
      ..y = 290);
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

  Offset _projectOffset(Offset offset) {
    return Offset(
      (offset.dx - _translateFactor.x) / _scaleFactor,
      (offset.dy - _translateFactor.y) / _scaleFactor,
    );
  }

  void updateMouse(Offset offset) {
    mousePos = _projectOffset(offset);
  }

  @override
  void onTapUp(details) {
    final projectedOffset = _projectOffset(details.localPosition);

    List<Fish> fishes() =>
        components.where((c) => c is Fish).cast<Fish>().toList();

    final fish = fishes().firstWhere(
      (o) => o.toRect().contains(projectedOffset),
      orElse: () => null,
    );

    if (fish != null) {
      showFishInfo(fish.fishInfo);
    } else {
      fishes().forEach((f) {
        f.setTarget(Position(projectedOffset.dx, projectedOffset.dy));
      });
    }
  }

  void showFishInfo(FishInfo fishInfo) {
    addWidgetOverlay(
      'fishOverlay',
      FishOverlay(
        fishInfo: fishInfo,
        onCloseInfo: () => removeWidgetOverlay('fishOverlay'),
      ),
    );
  }
}
