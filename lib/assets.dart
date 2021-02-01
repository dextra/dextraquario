import 'dart:ui' as dui;

import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class Assets {
  static FireAtlas fishes;
  static FireAtlas background;
  static FireAtlas ui;
  static Sprite bubble;
  static dui.Image buttonImage;

  static Future<void> load() async {
    fishes = await FireAtlas.loadAsset('atlases/fishes.fa');
    background = await FireAtlas.loadAsset('atlases/background.fa');
    ui = await FireAtlas.loadAsset('atlases/ui.fa');

    final _bubbleImage = await Flame.images.load('bubble.png');
    bubble = Sprite(_bubbleImage);

    buttonImage = await Flame.images.load('button.png');
  }
}
