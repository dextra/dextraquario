import 'package:dextraquario/load_fishes.dart';
import 'package:dextraquario/widgets/ranking.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import 'dart:math';
import 'dart:html';

import 'dextra_quario.dart';
import 'components/fish.dart';
import 'assets.dart';
import 'widgets/ranking_link.dart';
import 'fish_info.dart';

import 'overlays/fish_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Assets.load();

  final fishes = await LoadFishes.loadFishes();
  final game = DextraQuario();

  int mostContributions = fishes.fold(
    0,
    (value, current) => max(value, current.fishItems.length),
  );

  window.addEventListener('visibilitychange', (Event event) {
    if (window.document.visibilityState == 'visible') {
      game.resumeEngine();
    } else {
      game.pauseEngine();
    }
  });

  fishes.forEach((fishInfo) {
    game.add(
      Fish(
        fishInfo: fishInfo,
        fishSize: fishInfo.fishItems.length / mostContributions,
      ),
    );
  });

  runApp(
    MaterialApp(
      title: 'DextrAquario',
      home: Scaffold(
        body: Stack(
          children: [
            MouseRegion(
              child: GameWidget<DextraQuario>(
                game: game,
                overlayBuilderMap: {
                  'fishOverlay': (ctx, game) {
                    return FishOverlay(
                        fishInfo: game.currentFishInfo,
                        onCloseInfo: () {
                          game.overlays.remove('fishOverlay');
                          game.currentFishInfo = null;
                        });
                  }
                },
              ),
              onHover: (event) {
                game.updateMouse(event.localPosition);
              },
            ),
            RankingWidget(fishes: fishes, game: game),
          ],
        ),
      ),
    ),
  );
}

class RankingWidget extends StatefulWidget {
  final List<FishInfo> fishes;
  final DextraQuario game;

  RankingWidget({this.fishes, this.game});

  State createState() => _RankingWidgetState();
}

class _RankingWidgetState extends State<RankingWidget> {
  bool _rankingVisible = false;

  void _hide() {
    setState(() {
      _rankingVisible = false;
    });
  }

  @override
  Widget build(_) {
    if (_rankingVisible)
      return Ranking(
        fishes: widget.fishes,
        showFishInfo: (fishInfo) {
          widget.game.showFishInfo(fishInfo);
          _hide();
        },
        onCollapse: () {
          _hide();
        },
      );

    return Container(
      padding: EdgeInsets.all(10),
      child: RankingLink(
        label: 'Ranking',
        onClick: () {
          setState(() {
            _rankingVisible = true;
          });
        },
      ),
    );
  }
}
