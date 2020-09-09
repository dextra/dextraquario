import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class Assets {
  static FireAtlas fishes;
  static FireAtlas background;
  static FireAtlas ui;
  static Sprite bubble;

  static Future<void> load() async {
    fishes = await FireAtlas.fromAsset('atlases/fishes.fa');
    background = await FireAtlas.fromAsset('atlases/background.fa');
    ui = await FireAtlas.fromAsset('atlases/ui.fa');

    final _bubbleImage = await Flame.images.load('bubble.png');
    bubble = Sprite.fromImage(_bubbleImage);
  }
}
