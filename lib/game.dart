import 'package:dextraquario/overlays/profile_overlay.dart';
import 'package:dextraquario/overlays/add_contribution_overlay.dart';
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
                      game.overlays.add('homeScreenOverlay');
                    },
                  );
                },
                'loginScreenOverlay': (ctx, game) {
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
                      game.overlays.remove('loginScreenOverlay');
                      game.overlays.add('homeScreenOverlay');
                    }
                  });
                },
                'homeScreenOverlay': (ctx, game) {
                  return HomeScreenOverlay(
                    onAddClick: () {
                      game.overlays.remove('homeScreenOverlay');
                      game.overlays.add('addContributionScreenOverlay');
                    },
                    onGearClick: () {
                      game.overlays.remove('homeScreenOverlay');
                      game.overlays.add('adminOverlay');
                    },
                    onRankingClick: () {
                      game.overlays.remove('homeScreenOverlay');
                      game.overlays.add('rankingOverlay');
                    },
                    onUserClick: () {
                      game.overlays.remove('homeScreenOverlay');
                      game.overlays.add('profileOverlay');
                    },
                    onLogoutClick: () async {
                      await authProvider.signOut();

                      game.overlays.remove('homeScreenOverlay');

                      game.overlays.add('loginScreenOverlay');
                    },
                    user: authProvider.user,
                  );
                },
                'adminOverlay': (ctx, game) {
                  return AdminOverlay(
                    onClose: () {
                      game.overlays.remove('adminOverlay');
                      game.overlays.add('homeScreenOverlay');
                    },
                  );
                },
                'rankingOverlay': (ctx, game) {
                  return RankingOverlay(
                    onClose: () {
                      game.overlays.remove('rankingOverlay');
                      game.overlays.add('homeScreenOverlay');
                    },
                    userAuth: authProvider.user,
                  );
                },
                'profileOverlay': (ctx, game) {
                  return ProfileOverlay(
                    onClose: () {
                      game.overlays.remove('profileOverlay');
                      game.overlays.add('homeScreenOverlay');
                    },
                    userID: authProvider.user.uid,
                  );
                },
                'addContributionScreenOverlay': (ctx, game) {
                  return AddContributionScreenOverlay(
                    onClick: () {
                      game.overlays.remove('addContributionScreenOverlay');
                      game.overlays.add('homeScreenOverlay');
                    },
                    user: authProvider.user,
                  );
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
