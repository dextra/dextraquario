import 'dart:ui' as dui;

import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class Assets {
  static FireAtlas fishes;
  static FireAtlas background;
  static FireAtlas ui;
  static Sprite bubble;
  static Sprite gear;
  static Sprite closeButton32;
  static Sprite closeButton48;
  static Sprite acceptButton32;
  static Sprite profileMedal;
  static dui.Image panelImage;
  static dui.Image buttonImage;
  static dui.Image logoutButton32;
  static dui.Image userEmptyBottom;
  static dui.Image userEmptyFrame;
  static dui.Image buttonShadow;
  static dui.Image panelShadow;

  static Future<void> load() async {
    fishes = await FireAtlas.loadAsset('atlases/fishes.fa');
    background = await FireAtlas.loadAsset('atlases/background.fa');
    ui = await FireAtlas.loadAsset('atlases/ui.fa');

    final _gearImage = await Flame.images.load('gear.png');
    gear = Sprite(_gearImage);

    final _bubbleImage = await Flame.images.load('bubble.png');
    bubble = Sprite(_bubbleImage);

    final _closeButton32 = await Flame.images.load('closeButton32.png');
    closeButton32 = Sprite(_closeButton32);

    final _closeButton48 = await Flame.images.load('closeButton48.png');
    closeButton48 = Sprite(_closeButton48);

    final _acceptButton32 = await Flame.images.load('acceptButton32.png');
    acceptButton32 = Sprite(_acceptButton32);

    userEmptyBottom = await Flame.images.load('user_image_panel_filled.png');

    userEmptyFrame = await Flame.images.load('user_image_panel_empty.png');
    buttonImage = await Flame.images.load('button.png');
    buttonShadow = await Flame.images.load('button_shadow.png');
    panelImage = await Flame.images.load('panel.png');
    panelShadow = await Flame.images.load('panel_shadow.png');
    logoutButton32 = await Flame.images.load('logoutButton32.png');
  }
}
