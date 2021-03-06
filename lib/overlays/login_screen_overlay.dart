import 'dart:ui';

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
                child: Image.asset('images/fish_green.png',
                    color: Color.fromRGBO(0, 0, 0, 0.75)),
                padding: EdgeInsets.only(top: 2.0, left: 2.0),
              ),
              ClipRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Image.asset('images/fish_green.png')))
            ],
          ),
          Container(
            child: Text(
              'dextraquário',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                height: 1.2,
                shadows: <Shadow>[
                  Shadow(
                    blurRadius: 0,
                    offset: Offset(4.0, 4.0),
                    color: Color.fromRGBO(0, 0, 0, 0.75),
                  ),
                ],
              ),
            ),
            padding: EdgeInsets.only(bottom: 144),
            transform: Matrix4.translationValues(0, -16, 0),
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
                          width: 264,
                          height: 48,
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
                          width: 264,
                          height: 48,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text(
                                      'Login com o',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        shadows: <Shadow>[
                                          Shadow(
                                              blurRadius: 0,
                                              offset: Offset(1.0, 1.0),
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.75))
                                        ],
                                      ),
                                    ),
                                    padding: EdgeInsets.only(right: 16.0)),
                                Stack(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                          'images/google_logo.png',
                                          color: Color.fromRGBO(0, 0, 0, 0.75)),
                                      padding:
                                          EdgeInsets.only(top: 1.0, left: 1.0),
                                    ),
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 0, sigmaY: 0),
                                        child: Image.asset(
                                            'images/google_logo.png'),
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
  }
}
