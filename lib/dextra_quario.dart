import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';

import 'dart:ui';

class DextraQuario extends BaseGame with HasWidgetsOverlay, HasTapableComponents {
  DextraQuario(Size screenSize) {
    this.size = screenSize;
  }
}
