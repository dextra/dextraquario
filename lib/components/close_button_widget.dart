import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/cupertino.dart';

import '../assets.dart';

class CloseButtonWidget extends StatelessWidget {
  final Function onClick;
  final double scaleFactor;
  CloseButtonWidget({this.onClick, this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 44 * scaleFactor, right: 44 * scaleFactor),
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              'images/closeButton48.png',
              color: Color.fromRGBO(0, 0, 0, 0.5),
              scale: 1 / scaleFactor,
            ),
            padding: EdgeInsets.only(top: 2.0 * scaleFactor, left: 0.0),
          ),
          SpriteButton(
            onPressed: () => onClick?.call(),
            label: null,
            width: 48 * scaleFactor,
            height: 48 * scaleFactor,
            sprite: Assets.closeButton48,
            pressedSprite: Assets.closeButton48,
          ),
        ],
      ),
    );
  }
}
