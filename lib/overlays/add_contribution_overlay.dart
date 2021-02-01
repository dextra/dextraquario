import 'dart:ui';

import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';

import '../assets.dart';

class AddContributionScreenOverlay extends StatelessWidget {
  final Function onClick;

  AddContributionScreenOverlay({this.onClick});

  @override
  Widget build(context) {
    return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 7,
          sigmaY: 7,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: []),
            ]));
  }
}
