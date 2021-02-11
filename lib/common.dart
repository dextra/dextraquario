import 'package:dextraquario/contribution.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'assets.dart';

class CommonColors {
  CommonColors._();

  static int boxInsetBackground = 0xFFC06C4C;
  static int listHeader = 0xFF9E5235;
  static int lightBorder = 0x5FEFCBBA;
  static int darkBorder = 0x5A000000;
  static Color darkBackground = Color.fromRGBO(161, 84, 48, 1);
  static Color lightBackground = Color.fromRGBO(192, 108, 76, 1);
}

class CommonText {
  CommonText._();

  static TextStyle panelTitle = TextStyle(
      fontSize: 18,
      height: 1,
      color: Colors.white,
      shadows: [
        Shadow(color: Colors.black.withOpacity(0.75), offset: Offset(1, 1))
      ]);
  static TextStyle itemTitle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1.2,
      shadows: [
        Shadow(color: Colors.black.withOpacity(0.75), offset: Offset(1, 1))
      ]);
  static TextStyle itemSubtitle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1.5,
      shadows: [
        Shadow(color: Colors.black.withOpacity(0.75), offset: Offset(1, 1))
      ]);
  static TextStyle itemText = TextStyle(
      color: Colors.white,
      fontSize: 12,
      height: 1.2,
      shadows: [
        Shadow(color: Colors.black.withOpacity(0.75), offset: Offset(1, 1))
      ]);
  static TextStyle heightOneShadow(double size) =>
      TextStyle(color: Colors.white, fontSize: size, height: 1, shadows: [
        Shadow(color: Colors.black.withOpacity(0.75), offset: Offset(1, 1))
      ]);
}

class Common {
  Common._();

  static Border insetBorder = Border(
    right: BorderSide(color: Color(CommonColors.lightBorder), width: 4.0),
    bottom: BorderSide(color: Color(CommonColors.lightBorder), width: 4.0),
    left: BorderSide(color: Color(CommonColors.darkBorder), width: 4.0),
    top: BorderSide(color: Color(CommonColors.darkBorder), width: 4.0),
  );
}

class ContributionItem extends StatelessWidget {
  final ContributionModel contribution;
  final int index;
  final bool canApprove;
  final String author;
  final df = DateFormat('dd/MM/yyyy');
  double scaleFactor;

  ContributionItem(
      {this.contribution,
      this.author,
      this.index,
      this.canApprove,
      this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
              vertical: 1.0 * scaleFactor, horizontal: 16.0 * scaleFactor),
          leading: Container(
            width: 64 * scaleFactor,
            height: 64 * scaleFactor,
            child: SpriteWidget(
              sprite: Assets.ui.getSprite(
                  contribution.category.toString().replaceAll('ItemType.', '')),
            ),
          ),
          trailing: Text(
            df.format(contribution.date),
            textScaleFactor: scaleFactor,
            style: CommonText.itemTitle,
          ),
          title: Text(
            contribution.description,
            textScaleFactor: scaleFactor,
            style: CommonText.itemTitle,
          ),
          subtitle: canApprove
              ? Text(
                  author,
                  textScaleFactor: scaleFactor,
                  style: CommonText.itemSubtitle,
                )
              : null,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 92 * scaleFactor,
                      right: 64 * scaleFactor,
                      bottom: 16 * scaleFactor),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        contribution.description +
                            "\n\n" +
                            contribution.contribution_link,
                        textScaleFactor: scaleFactor,
                        style: CommonText.itemSubtitle,
                      ),
                    ),
                  ]),
                ),
                canApprove
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: 48 * scaleFactor, bottom: 12 * scaleFactor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16 * scaleFactor),
                              child: SpriteButton(
                                  width: 32 * scaleFactor,
                                  height: 32 * scaleFactor,
                                  onPressed: null,
                                  label: null,
                                  sprite: Assets.closeButton32,
                                  pressedSprite: Assets.closeButton32),
                            ),
                            SpriteButton(
                                width: 32 * scaleFactor,
                                height: 32 * scaleFactor,
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
          height: 16 * scaleFactor,
          thickness: 1 * scaleFactor,
          indent: 20 * scaleFactor,
          endIndent: 20 * scaleFactor,
        ),
      ],
    );
  }
}
