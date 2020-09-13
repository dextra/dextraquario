import 'package:dextraquario/fish_info.dart';
import 'package:flutter/material.dart';
import 'package:flame/widgets/sprite_widget.dart';

import '../assets.dart';

class RankingItem extends StatelessWidget {
  final FishInfo fish;

  TextStyle _mapTextStyle(int ranking) {
    return TextStyle(fontSize: ranking > 3 ? 14 : 28, color: Color(0xffcdff9d));
  }

  RankingItem({this.fish});
  @override
  Widget build(_) {
    final textStyle = _mapTextStyle(fish.ranking);

    final sprite = Assets.fishes.getAnimation(fish.fishColor).getSprite();

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Color(0xFF37946e),
              ),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          margin: EdgeInsets.only(
            bottom: 10,
            left: 10,
            right: 10,
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              Container(
                width: 20,
                child: Text(fish.ranking.toString(), style: textStyle),
              ),
              SizedBox(width: 10),
              Container(
                width: 80,
                height: 40,
                child: SpriteWidget(
                  sprite: sprite,
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fish.name,
                        style: textStyle, overflow: TextOverflow.ellipsis),
                    Text("Score: ${fish.fishItems.length}", style: textStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
