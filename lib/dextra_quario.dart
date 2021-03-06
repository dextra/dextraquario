import 'package:flame/extensions/vector2.dart';
import 'package:flame/gestures.dart';
import 'package:flame/game.dart';

import 'dart:ui';

import './fish_info.dart';
import './components/background.dart';
import './components/foreground.dart';
import './components/fish.dart';
import './components/bubble_source.dart';

class DextraQuario extends BaseGame with TapDetector {
  static const GAME_WIDTH = 1440;
  static const GAME_HEIGHT = 900;

  double _scaleFactor;
  Vector2 _translateFactor;

  Offset mousePos;

  FishInfo currentFishInfo;

  @override
  Future<void> onLoad() async {
    _calcScaleFactor();

    add(Background());
    add(Foreground());
    add(
      BubbleSource()
        ..x = 414
        ..y = 819,
    );
    add(
      BubbleSource()
        ..x = 1242
        ..y = 769,
    );
  }

  void _calcScaleFactor() {
    final window_width = size.x;
    final window_height = size.y;

    if (GAME_WIDTH > GAME_HEIGHT) {
      if ((window_width / window_height) > (GAME_WIDTH / GAME_HEIGHT)) {
        _scaleFactor = window_width / GAME_WIDTH;
      } else {
        _scaleFactor = window_height / GAME_HEIGHT;
      }
    } else {
      if ((window_height / window_width) > (GAME_HEIGHT / GAME_WIDTH)) {
        _scaleFactor = window_width / GAME_HEIGHT;
      } else {
        _scaleFactor = window_height / GAME_WIDTH;
      }
    }

    _scaleFactor = _scaleFactor + _scaleFactor * 0.02;

    final _finalWidth = _scaleFactor * GAME_WIDTH;
    final _finalHeight = _scaleFactor * GAME_HEIGHT;

    _translateFactor = Vector2(
      size.x / 2 - _finalWidth / 2,
      size.y / 2 - _finalHeight / 2,
    );
  }

  @override
  void onResize(Vector2 size) {
    super.onResize(size);

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
        f.setTarget(Vector2(projectedOffset.dx, projectedOffset.dy));
      });
    }
  }

  void showFishInfo(FishInfo fishInfo) {
    currentFishInfo = fishInfo;
    overlays.add('fishOverlay');
    overlays.remove('homeScreenOverlay');
  }
}
