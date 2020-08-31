import 'package:flame_fire_atlas/flame_fire_atlas.dart';

class Assets {
  static FireAtlas fishes;
  static FireAtlas background;
  static FireAtlas ui;

  static Future<void> load() async {
    fishes = await FireAtlas.fromAsset('atlases/fishes.fa');
    background = await FireAtlas.fromAsset('atlases/background.fa');
    ui = await FireAtlas.fromAsset('atlases/ui.fa');
  }
}
