import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/cupertino.dart';

import '../assets.dart';

class CloseButtonWidget extends StatelessWidget {
  final Function onClick;
  CloseButtonWidget({this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 44, right: 44),
      child: Stack(
        children: [
          Container(
            child: Image.asset('images/closeButton48.png',
                color: Color.fromRGBO(0, 0, 0, 0.5)),
            padding: EdgeInsets.only(top: 2.0, left: 0.0),
          ),
          SpriteButton(
            onPressed: () => onClick?.call(),
            label: null,
            width: 48,
            height: 48,
            sprite: Assets.closeButton48,
            pressedSprite: Assets.closeButton48,
          ),
        ],
      ),
    );
  }
}
