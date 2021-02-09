import 'dart:ui';

import 'package:dextraquario/components/close_button_widget.dart';
import 'package:dextraquario/components/custom_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';
import '../models/user_model.dart';
import '../services/contribution_service.dart';
import '../services/contribution_service.dart';

class AddContributionScreenOverlay extends StatefulWidget {
  final Function onClick;
  final User user;

  AddContributionScreenOverlay({this.onClick, this.user});

  @override
  _AddContributionScreenOverlayState createState() =>
      _AddContributionScreenOverlayState();
}

class _AddContributionScreenOverlayState
    extends State<AddContributionScreenOverlay> {
  final descricaoController = TextEditingController();
  final linkController = TextEditingController();
  final tipoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ContributionServices _contributionServices = ContributionServices();

  @override
  Widget build(context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 7,
        sigmaY: 7,
      ),
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: Opacity(
                            child: NineTileBox(
                              image: Assets.panelShadow,
                              tileSize: 12,
                              destTileSize: 24,
                              width: 559,
                              height: 597,
                            ),
                            opacity: 0.5,
                          ),
                          padding: EdgeInsets.only(top: 4.0, left: 2.0),
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                            child: NineTileBox(
                              image: Assets.panelImage,
                              tileSize: 12,
                              destTileSize: 16,
                              width: 559,
                              height: 597,
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 68,
                                      child: Text(
                                        'Adicionar contribuição',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          height: 1,
                                          fontWeight: FontWeight.w400,
                                          shadows: <Shadow>[
                                            Shadow(
                                              blurRadius: 0,
                                              offset: Offset(1.0, 1.0),
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.75),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Divider(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          thickness: 1,
                                          height: 1,
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                          thickness: 2,
                                          height: 2,
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 2,
                                          height: 2,
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                          thickness: 2,
                                          height: 2,
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          thickness: 1,
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 24),
                                      width: 486,
                                      height: 96,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tipo de contribuição',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              height: 1,
                                              fontWeight: FontWeight.w400,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  blurRadius: 0,
                                                  offset: Offset(1.0, 1.0),
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.5),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 10.0),
                                            height: 56,
                                            child: CustomDropdown(
                                              onClick: (String option) {
                                                tipoController.text = option;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 486,
                                      height: 133,
                                      padding: EdgeInsets.only(top: 24),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Link da contribuição',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  height: 1.2,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      blurRadius: 0,
                                                      offset: Offset(1.0, 1.0),
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.75),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 20.5),
                                                child: Text(
                                                  '(Opcional)',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    height: 1.2,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        blurRadius: 0,
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.75),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 486,
                                            height: 56,
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 24),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(CommonColors
                                                      .boxInsetBackground),
                                                ),
                                              ],
                                              border: _insetBorder(),
                                            ),
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: TextFormField(
                                                controller: linkController,
                                                cursorColor: Colors.black,
                                                decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      blurRadius: 0,
                                                      offset: Offset(1.0, 1.0),
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.75),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 486,
                                      height: 211,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Descrição',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              height: 1.2,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  blurRadius: 0,
                                                  offset: Offset(1.0, 1.0),
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.75),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 486,
                                            height: 152,
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 30),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(CommonColors
                                                      .boxInsetBackground),
                                                ),
                                              ],
                                              border: _insetBorder(),
                                            ),
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: TextFormField(
                                                controller: descricaoController,
                                                cursorColor: Colors.black,
                                                maxLines: 6,
                                                maxLength: 140,
                                                buildCounter: (_,
                                                        {currentLength,
                                                        maxLength,
                                                        isFocused}) =>
                                                    Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Text(currentLength
                                                            .toString() +
                                                        "/" +
                                                        maxLength.toString()),
                                                  ),
                                                ),
                                                decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      blurRadius: 0,
                                                      offset: Offset(1.0, 1.0),
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.75),
                                                    ),
                                                  ],
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Uma descrição deve ser inserida';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _contributionServices
                                                .createContribution(
                                                    widget.user.uid,
                                                    DateTime.now(),
                                                    descricaoController.text,
                                                    linkController.text,
                                                    tipoController.text);
                                          }
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              child: Opacity(
                                                child: NineTileBox(
                                                  image: Assets.buttonShadow,
                                                  tileSize: 12,
                                                  destTileSize: 12,
                                                  width: 164,
                                                  height: 44,
                                                ),
                                                opacity: 0.5,
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 2.0, left: 2.0),
                                            ),
                                            ClipRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 0, sigmaY: 0),
                                                child: NineTileBox(
                                                  image: Assets.buttonImage,
                                                  tileSize: 12,
                                                  destTileSize: 12,
                                                  width: 164,
                                                  height: 44,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            'Enviar',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              height: 1,
                                                              shadows: <Shadow>[
                                                                Shadow(
                                                                    blurRadius:
                                                                        0,
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.75))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: CloseButtonWidget(onClick: widget.onClick),
            ),
          ],
        ),
      ),
    );
  }
}

Border _insetBorder() {
  return Border(
      right: BorderSide(color: Color(CommonColors.lightBorder), width: 2.0),
      bottom: BorderSide(color: Color(CommonColors.lightBorder), width: 2.0),
      left: BorderSide(color: Color(CommonColors.darkBorder), width: 2.0),
      top: BorderSide(color: Color(CommonColors.darkBorder), width: 2.0));
}
