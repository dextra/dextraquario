import 'package:dextraquario/fish_info.dart';
import 'package:flutter/material.dart';

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
            width: 600,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(fishInfo.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    GestureDetector(
                      child: Text('Fechar'),
                      onTap: onCloseInfo,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  color: Colors.red[300],
                  width: 250,
                  height: 250,
                ),
                Text(fishInfo.fishItems[1].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(fishInfo.fishItems[1].description, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                fishInfo.fishItems[1].link != null
                    ? Text(fishInfo.fishItems[1].link, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                    : Text(''),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
