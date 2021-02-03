import 'package:dextraquario/overlays/ranking_overlay.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flutter/material.dart';

import 'dart:html';

import 'dextra_quario.dart';
import 'package:dextraquario/providers/app.dart';
import 'package:dextraquario/providers/auth.dart';
import 'package:provider/provider.dart';

import 'overlays/admin_overlay.dart';
import 'overlays/fish_overlay.dart';
import './dextra_quario.dart';

import './overlays/fish_overlay.dart';
import './overlays/login_screen_overlay.dart';
import './overlays/home_screen_overlay.dart';
import 'overlays/gear_overlay.dart';

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
                'LoginScreenOverlay': (ctx, game) {
                  return LoginScreenOverlay(onClick: () async {
                    Map result = await authProvider.signInWithGoogle();
                    bool success = result['success'];
                    String message = result['message'];

                    if (!success) {
                      ScaffoldMessenger.of(ctx)
                          .showSnackBar(SnackBar(content: Text(message)));
                      appProvider.changeLoading();
                    } else {
                      appProvider.changeLoading();
                      game.overlays.remove('LoginScreenOverlay');
                      game.overlays.add('HomeScreenOverlay');
                      game.overlays.add('gearOverlay');
                    }
                  });
                },
                'HomeScreenOverlay': (ctx, game) {
                  return HomeScreenOverlay();
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
                'rankingOverlay': (ctx, game) {
                  return RankingOverlay(
                    onClose: () {
                      game.overlays.remove('rankingOverlay');
                    },
                  );
                },
                'addContributionScreenOverlay': (ctx, game) {
                  return null;
                }
              },
              initialActiveOverlays: ['LoginScreenOverlay'],
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
