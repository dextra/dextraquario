import 'package:dextraquario/fish_info.dart';
import 'package:dextraquario/widgets/ranking_item.dart';
import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  final List<FishInfo> fishes;

  Ranking({this.fishes});
  @override
  Widget build(_) {
    return Container(
      decoration: BoxDecoration(color: Colors.red),
      width: 400,
      child: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Row(children: [
              SizedBox(width: 10),
              Text('# Ranking', style: TextStyle(fontSize: 50, color: Colors.white)),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: fishes.map((fish) => RankingItem(fish: fish)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
