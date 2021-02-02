import 'package:dextraquario/load_fishes.dart';
import 'package:dextraquario/overlays/admin_overlay.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:html';

import './dextra_quario.dart';
import './components/fish.dart';
import './assets.dart';

import './overlays/fish_overlay.dart';
import 'overlays/gear_overlay.dart';
import './overlays/login_screen_overlay.dart';
import './overlays/home_screen_overlay.dart';
import './overlays/add_contribution_overlay.dart';

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
      theme: ThemeData(
          fontFamily: 'Press Start 2P',
          dividerColor: Colors.transparent,
          highlightColor: Color(0xFFA15531)),
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
                  },
                  'gearOverlay': (ctx, game) {
                    return GearOverlay(
                      onOpen: () {
                        if (!game.overlays.isActive('adminOverlay')) {
                          game.overlays.add('adminOverlay');
                          game.overlays.remove('gearOverlay');
                        }
                      },
                    );
                  },
                  'adminOverlay': (ctx, game) {
                    return AdminOverlay(
                      onClose: () {
                        game.overlays.remove('adminOverlay');
                        game.overlays.add('gearOverlay');
                      },
                    );
                  },
                  'loginScreenOverlay': (ctx, game) {
                    return LoginScreenOverlay(onClick: () {
                      game.overlays.remove('loginScreenOverlay');
                      game.overlays.add('homeScreenOverlay');
                      game.overlays.add('gearOverlay');
                    });
                  },
                  'homeScreenOverlay': (ctx, game) {
                    return HomeScreenOverlay();
                  },
                  'addContributionScreenOverlay': (ctx, game) {
                    return AddContributionScreenOverlay();
                  }
                },
                initialActiveOverlays: ['loginScreenOverlay'],
              ),
              onHover: (event) {
                game.updateMouse(event.localPosition);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
