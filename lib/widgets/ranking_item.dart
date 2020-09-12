import 'package:dextraquario/fish_info.dart';
import 'package:flutter/material.dart';

class RankingItem extends StatelessWidget {
  final FishInfo fish;

  RankingItem({this.fish});
  @override
  Widget build(_) {
    const textStyle = TextStyle(fontSize: 20, color: Colors.white);

    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            Container(
              width: 30,
              child: Column(
                children: [Text(fish.ranking.toString(), style: textStyle)],
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(fish.name, style: textStyle, overflow: TextOverflow.ellipsis)],
              ),
            ),
            Container(
              width: 30,
              child: Column(
                children: [Text(fish.fishItems.length.toString(), style: textStyle)],
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
