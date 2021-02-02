import 'package:dextraquario/load_fishes.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:html';

import 'dextra_quario.dart';
import 'components/fish.dart';
import 'assets.dart';
import 'widgets/ranking_link.dart';
import 'fish_info.dart';
import 'package:dextraquario/providers/app.dart';
import 'package:dextraquario/providers/auth.dart';
import 'package:dextraquario/screens/authentication.dart';
import 'package:dextraquario/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'helper/constants.dart';
import 'package:dextraquario/services/user_service.dart';
import 'overlays/fish_overlay.dart';
import './dextra_quario.dart';
import './components/fish.dart';
import './assets.dart';

import './overlays/fish_overlay.dart';
import './overlays/login_screen_overlay.dart';
import './overlays/home_screen_overlay.dart';

class GameScreen extends StatelessWidget {
  final DextraQuario game;
  GameScreen({this.game});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
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
                'loginScreenOverlay': (ctx, game) {
                  return loginScreenOverlay(onClick: () async {
                    Map result = await authProvider.signInWithGoogle();
                    bool success = result['success'];
                    String message = result['message'];
                    print(message);

                    if (!success) {
                      ScaffoldMessenger.of(ctx)
                          .showSnackBar(SnackBar(content: Text(message)));
                      appProvider.changeLoading();
                    } else {
                      appProvider.changeLoading();
                      print("Success aconteceu");
                      game.overlays.remove('loginScreenOverlay');
                      game.overlays.add('homeScreenOverlay');
                    }
                  });
                },
                'homeScreenOverlay': (ctx, game) {
                  //return homeScreenOverlay(onClick: () {});
                  return homeScreenOverlay();
                },
                'addContributionScreenOverlay': (ctx, game) {
                  return null;
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
    );
  }
}
