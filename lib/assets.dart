import 'dart:typed_data';
import 'dart:ui' as dui;

import 'package:flame/nine_tile_box.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

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

    buttonImage = await _getImage('images/button.png');
  }

  static Future<dui.Image> _getImage(String imageAssetPath) async {
    ByteData byteData = await rootBundle.load(imageAssetPath);
    Uint8List uint8list = new Uint8List.view(byteData.buffer);
    dui.Codec codec = await dui.instantiateImageCodec(uint8list);
    dui.FrameInfo frameInfo = await codec.getNextFrame();

    return frameInfo.image;
  }
}
