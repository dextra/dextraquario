import 'package:dextraquario/assets.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';

class GearOverlay extends StatelessWidget {
  final Function onOpen;

  GearOverlay({this.onOpen});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        child: Container(
          width: 48,
          height: 48,
          child: SpriteWidget(sprite: Assets.gear),
        ),
        onTap: () => onOpen?.call(),
      )
    ]);
  }
}
