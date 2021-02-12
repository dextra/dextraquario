import 'dart:ui';

import 'package:dextraquario/utils/scale_factor_calculator.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';
import 'package:dextraquario/providers/app.dart';
import 'package:provider/provider.dart';
import '../assets.dart';

class LoginScreenOverlay extends StatelessWidget {
  final Function onClick;

  LoginScreenOverlay({this.onClick});

  @override
  Widget build(context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    appProvider.changeLoading();
    return LayoutBuilder(builder: (context, constraints) {
      var scaleFactor = ScaleFactorCalculator.calcScaleFactor(
          constraints.maxWidth, constraints.maxHeight);

      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 7,
          sigmaY: 7,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    'images/fish_green.png',
                    color: Color.fromRGBO(0, 0, 0, 0.75),
                    scale: 1.0 / scaleFactor,
                  ),
                  padding: EdgeInsets.only(
                      top: 2.0 * scaleFactor, left: 2.0 * scaleFactor),
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Image.asset('images/fish_green.png',
                        scale: 1.0 / scaleFactor),
                  ),
                ),
              ],
            ),
            Container(
              child: Text(
                'dextraquário',
                textScaleFactor: scaleFactor,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  height: 1.2,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 0,
                      offset: Offset(4.0 * scaleFactor, 4.0 * scaleFactor),
                      color: Color.fromRGBO(0, 0, 0, 0.75),
                    ),
                  ],
                ),
              ),
              padding: EdgeInsets.only(bottom: 144 * scaleFactor),
              transform: Matrix4.translationValues(0, -16 * scaleFactor, 0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        child: Opacity(
                          child: NineTileBox(
                            image: Assets.buttonShadow,
                            tileSize: 12,
                            destTileSize: 16,
                            width: 264 * scaleFactor,
                            height: 48 * scaleFactor,
                          ),
                          opacity: 0.5,
                        ),
                        padding: EdgeInsets.only(top: 1.0, left: 1.0),
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: NineTileBox(
                            image: Assets.buttonImage,
                            tileSize: 12,
                            destTileSize: 16,
                            width: 264 * scaleFactor,
                            height: 48 * scaleFactor,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'Login com o',
                                      textScaleFactor: scaleFactor,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        shadows: <Shadow>[
                                          Shadow(
                                              blurRadius: 0,
                                              offset: Offset(1.0 * scaleFactor,
                                                  1.0 * scaleFactor),
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.75))
                                        ],
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                        right: 16.0 * scaleFactor),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          'images/google_logo.png',
                                          scale: 1 / scaleFactor,
                                          color: Color.fromRGBO(0, 0, 0, 0.75),
                                        ),
                                        padding: EdgeInsets.only(
                                            top: 1.0 * scaleFactor,
                                            left: 1.0 * scaleFactor),
                                      ),
                                      ClipRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 0, sigmaY: 0),
                                          child: Image.asset(
                                              'images/google_logo.png',
                                              scale: 1 / scaleFactor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    onClick?.call();
                  },
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
