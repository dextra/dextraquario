import 'package:dextraquario/providers/app.dart';
import 'package:dextraquario/providers/auth.dart';
import 'package:dextraquario/widgets/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:dextraquario/load_fishes.dart';

import 'dart:math';
import 'dart:html';

import 'dextra_quario.dart';
import 'components/fish.dart';
import 'assets.dart';
import 'game.dart';

import './dextra_quario.dart';
import './components/fish.dart';
import './assets.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await Assets.load();
    await Firebase.initializeApp();
    await _googleSignIn.disconnect();
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

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AppProvider()),
          ChangeNotifierProvider.value(value: AuthProvider.init()),
        ],
        child: MaterialApp(
          title: 'Dextraquario',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Press Start 2P',
            dividerColor: Colors.transparent,
            highlightColor: Color(0xFFA15531),
          ),
          home: AppScreensController(game: game),
        ),
      ),
    );
  } catch (err) {
    print(err);
  }
}

class AppScreensController extends StatelessWidget {
  final DextraQuario game;
  AppScreensController({this.game});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.Uninitialized:
        return Loading();
      default:
        return GameScreen(game: game);
    }
  }
}
