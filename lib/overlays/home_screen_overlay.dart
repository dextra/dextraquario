import 'dart:ui';

import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';

import '../assets.dart';

class homeScreenOverlay extends StatelessWidget {
  final Function onClick;

  homeScreenOverlay({this.onClick});

  @override
  Widget build(context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  child:
                      Image.asset('images/fish_green.png', color: Colors.black),
                  padding: EdgeInsets.only(top: 2.0, left: 2.0)),
              ClipRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Image.asset('images/fish_green.png')))
            ],
          )
        ]);
  }
}
