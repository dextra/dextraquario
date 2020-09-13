import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/widgets/ranking_item.dart';
import 'package:flutter/material.dart';

import './ranking_link.dart';

class Ranking extends StatelessWidget {
  final List<FishInfo> fishes;
  final VoidCallback onCollapse;

  Ranking({this.fishes, this.onCollapse});
  @override
  Widget build(_) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF59a888),
        border: Border(
          right: BorderSide(
            width: 5,
            color: Color(0xFF53987c),
          ),
        ),
      ),
      width: 440,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 25,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RankingLink(label: 'Close', onClick: onCollapse),
              ],
            ),
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Text(
                  'Ranking',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF21674a),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: fishes
                    .map((fish) => RankingItem(
                          fish: fish,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
