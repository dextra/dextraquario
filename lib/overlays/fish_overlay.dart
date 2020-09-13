import 'package:dextraquario/components/carousel_items.dart';
import 'package:dextraquario/fish_info.dart';
import 'package:flutter/material.dart';
import 'package:flame/widgets/sprite_widget.dart';

import '../assets.dart';

class FishOverlay extends StatelessWidget {
  final FishInfo fishInfo;
  final Function onCloseInfo;

  FishOverlay({this.fishInfo, this.onCloseInfo});

  @override
  Widget build(context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 500,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(fishInfo.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: SpriteWidget(
                          sprite: Assets.ui.getSprite('close'),
                        ),
                      ),
                      onTap: onCloseInfo,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CarouselItems(items: fishInfo.fishItems),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.white, spreadRadius: 3),
              ],
            ),
          )
        ],
      ),
    );
  }
}
