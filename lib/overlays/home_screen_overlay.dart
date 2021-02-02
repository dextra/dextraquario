import 'dart:ui';

import 'package:flutter/material.dart';

class homeScreenOverlay extends StatelessWidget {
  homeScreenOverlay();

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
                  child: Image.asset('images/fish_green.png'),
                ),
              ),
            ],
          )
        ]);
  }
}
