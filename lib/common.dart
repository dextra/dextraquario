import 'package:dextraquario/models/contribution_model.dart';
import 'package:dextraquario/services/contribution_service.dart';
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
  final String author;
  final int index;
  final bool canApprove;
  final Function updateList;
  final df = new DateFormat('dd/MM/yyyy');

  ContributionItem(
      {this.contribution,
      String this.author,
      int this.index,
      this.canApprove,
      this.updateList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpansionTile(
          leading: Container(
            width: 64,
            height: 64,
            child: SpriteWidget(
              sprite: Assets.ui.getSprite(
                contribution.category.type,
              ),
            ),
          ),
          trailing: Text(
            df.format(contribution.date),
            style: CommonText.itemTitle,
          ),
          title: Text(
            contribution.getItemTitle(),
            style: CommonText.itemTitle,
          ),
          subtitle: canApprove
              ? Text(
                  author,
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          contribution.description +
                              "\n\n" +
                              contribution.contribution_link,
                          style: CommonText.itemSubtitle,
                        ),
                      ),
                    ],
                  ),
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
                                onPressed: () {
                                  ContributionServices()
                                      .updateContributionApproval(
                                    contribution.contribution_id,
                                    false,
                                    contribution.user_id,
                                  );
                                  updateList?.call();
                                },
                                label: null,
                                sprite: Assets.closeButton32,
                                pressedSprite: Assets.closeButton32,
                              ),
                            ),
                            SpriteButton(
                              width: 32,
                              height: 32,
                              onPressed: () {
                                ContributionServices()
                                    .updateContributionApproval(
                                  contribution.contribution_id,
                                  true,
                                  contribution.user_id,
                                );
                                updateList?.call();
                              },
                              label: null,
                              sprite: Assets.closeButton32,
                              pressedSprite: Assets.closeButton32,
                            ),
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
