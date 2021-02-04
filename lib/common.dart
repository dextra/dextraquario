import 'package:dextraquario/contribution.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';

import 'assets.dart';

class CommonColors {
  CommonColors._();

  static int boxInsetBackground = 0xFFC06C4C;
  static int listHeader = 0xFF9E5235;
  static int lightBorder = 0x5FEFCBBA;
  static int darkBorder = 0x5A000000;
}

class CommonText {
  CommonText._();

  static TextStyle panelTitle =
      TextStyle(fontSize: 18, height: 1, color: Colors.white);
  static TextStyle itemTitle =
      TextStyle(color: Colors.white, fontSize: 14, height: 1.2);
  static TextStyle itemSubtitle =
      TextStyle(color: Colors.white, fontSize: 14, height: 1.5);
}

class Common {
  Common._();

  static Border insetBorder = Border(
    right: BorderSide(color: Color(CommonColors.lightBorder), width: 4.0),
    bottom: BorderSide(color: Color(CommonColors.lightBorder), width: 4.0),
    left: BorderSide(color: Color(CommonColors.darkBorder), width: 4.0),
    top: BorderSide(color: Color(CommonColors.darkBorder), width: 4.0),
  );

  static Widget contributionItem(Contribution contribution, int index,
      {bool canApprove = true}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpansionTile(
          leading: Container(
            width: 64,
            height: 64,
            child: SpriteWidget(
              sprite: Assets.ui.getSprite(
                contribution.type.toString().replaceAll('ItemType.', ''),
              ),
            ),
          ),
          trailing: Text(
            contribution.date.toString(),
            style: CommonText.itemTitle,
          ),
          title: Text(
            contribution.getItemDescription(),
            style: CommonText.itemTitle,
          ),
          subtitle: canApprove
              ? Text(
                  contribution.author,
                  style: CommonText.itemSubtitle,
                )
              : null,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 92, right: 64, bottom: 16),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        contribution.description + "\n\n" + contribution.link,
                        style: CommonText.itemSubtitle,
                      ),
                    ),
                  ]),
                ),
                canApprove
                    ? Padding(
                        padding: EdgeInsets.only(right: 48, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: SpriteButton(
                                  width: 32,
                                  height: 32,
                                  onPressed: null,
                                  label: null,
                                  sprite: Assets.closeButton32,
                                  pressedSprite: Assets.closeButton32),
                            ),
                            SpriteButton(
                                width: 32,
                                height: 32,
                                onPressed: null,
                                label: null,
                                sprite: Assets.closeButton32,
                                pressedSprite: Assets.closeButton32),
                          ],
                        ),
                      )
                    : Center()
              ],
            )
          ],
        ),
        Divider(
          color: Colors.black26,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
