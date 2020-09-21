import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/widgets/custom_link.dart';
import 'package:flutter/material.dart';

import 'package:flame/widgets/sprite_widget.dart';

import '../assets.dart';

class CardItem extends StatelessWidget {
  final FishItem fishItem;

  CardItem({this.fishItem});

  @override
  Widget build(_) {
    return Column(
      children: [
        Container(
          width: 250,
          height: 250,
          child: SpriteWidget(
            sprite: Assets.ui.getSprite(
              fishItem.name.toString().replaceAll('ItemType.', ''),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          fishItem.getItemDescription(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        Text(
          fishItem.description,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 30),
        fishItem.link != '' ? CustomLink(url: fishItem.link) : Text('')
      ],
    );
  }
}
