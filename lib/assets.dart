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
  static dui.Image buttonShadow;
  static dui.Image panelImage;
  static dui.Image panelShadow;
  static dui.Image closeButtonImage;

  static Future<void> load() async {
    fishes = await FireAtlas.loadAsset('atlases/fishes.fa');
    background = await FireAtlas.loadAsset('atlases/background.fa');
    ui = await FireAtlas.loadAsset('atlases/ui.fa');

    final _bubbleImage = await Flame.images.load('bubble.png');
    bubble = Sprite(_bubbleImage);

    buttonImage = await Flame.images.load('button.png');
    buttonShadow = await Flame.images.load('button_shadow.png');
    panelImage = await Flame.images.load('panel.png');
    panelShadow = await Flame.images.load('panel_shadow.png');
    closeButtonImage = await Flame.images.load('close_button.png');
  }
}
