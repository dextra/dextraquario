import 'dart:js';

import 'package:dextraquario/providers/app.dart';
import 'package:dextraquario/providers/auth.dart';
import 'package:dextraquario/screens/authentication.dart';
import 'package:dextraquario/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dextraquario/load_fishes.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:html';

import 'dextra_quario.dart';
import 'components/fish.dart';
import 'assets.dart';
import 'game.dart';
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

  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: AuthProvider.init()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dextraquario',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AppScreensController(game: game),
      )));
}

class AppScreensController extends StatelessWidget {
  final DextraQuario game;
  AppScreensController({this.game});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserServices userServices = UserServices();
    switch (authProvider.status) {
      case Status.Uninitialized:
        print('uninitialized');
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        print('authenticating');
        return GameScreen(game: game);
      case Status.Authenticated:
        print('O usuario conseguiu entrar na plataforma');
        return GameScreen(game: game);
      default:
        print('default');
        return GameScreen(game: game);
    }
  }
}
