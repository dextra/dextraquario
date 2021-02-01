import 'dart:ui' as dui;

import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class Assets {
  static FireAtlas fishes;
  static FireAtlas background;
  static FireAtlas ui;
  static Sprite bubble;
  static Sprite panelTile;
  static Sprite gear;
  static dui.Image panelImage;

  static Future<void> load() async {
    fishes = await FireAtlas.loadAsset('atlases/fishes.fa');
    background = await FireAtlas.loadAsset('atlases/background.fa');
    ui = await FireAtlas.loadAsset('atlases/ui.fa');

    final _bubbleImage = await Flame.images.load('bubble.png');
    bubble = Sprite(_bubbleImage);

    panelImage = await Flame.images.load('panelTile.png');
    panelTile = Sprite(panelImage);

    final _gearImage = await Flame.images.load('gear48.png');
    gear = Sprite(_gearImage);
  }
}
