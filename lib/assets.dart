import 'package:flame_fire_atlas/flame_fire_atlas.dart';

class Assets {
  static FireAtlas fishes;

  static Future<void> load() async {
    fishes = await FireAtlas.fromAsset('atlases/fishes.fa');
  }
}
