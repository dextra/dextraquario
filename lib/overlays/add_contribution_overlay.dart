import 'dart:ui';

import 'package:dextraquario/components/close_button_widget.dart';
import 'package:dextraquario/components/custom_dropdown.dart';
import 'package:dextraquario/utils/scale_factor_calculator.dart';
import 'package:dextraquario/models/contribution_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../common.dart';
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
    return LayoutBuilder(builder: (context, constraints) {
      double scaleFactor = ScaleFactorCalculator.calcScaleFactor(
          constraints.maxWidth, constraints.maxHeight);

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
                                width: 559 * scaleFactor,
                                height: 597 * scaleFactor,
                              ),
                              opacity: 0.5,
                            ),
                            padding: EdgeInsets.only(
                                top: 4.0 * scaleFactor,
                                left: 2.0 * scaleFactor),
                          ),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                              child: NineTileBox(
                                image: Assets.panelImage,
                                tileSize: 12,
                                destTileSize: 16,
                                width: 559 * scaleFactor,
                                height: 597 * scaleFactor,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 68 * scaleFactor,
                                        child: Text(
                                          'Adicionar contribuição',
                                          textScaleFactor: scaleFactor,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            height: 1,
                                            fontWeight: FontWeight.w400,
                                            shadows: <Shadow>[
                                              Shadow(
                                                blurRadius: 0,
                                                offset: Offset(
                                                    1.0 * scaleFactor,
                                                    1.0 * scaleFactor),
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.75),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Divider(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
                                            thickness: 1 * scaleFactor,
                                            height: 1 * scaleFactor,
                                          ),
                                          Divider(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            thickness: 2 * scaleFactor,
                                            height: 2 * scaleFactor,
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            thickness: 2 * scaleFactor,
                                            height: 2 * scaleFactor,
                                          ),
                                          Divider(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            thickness: 2 * scaleFactor,
                                            height: 2 * scaleFactor,
                                          ),
                                          Divider(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
                                            thickness: 1 * scaleFactor,
                                            height: 1 * scaleFactor,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 23 * scaleFactor),
                                        width: 486 * scaleFactor,
                                        height: 96 * scaleFactor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tipo de contribuição',
                                              textScaleFactor: scaleFactor,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                height: 1 * scaleFactor,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    blurRadius: 0,
                                                    offset: Offset(
                                                        1.0 * scaleFactor,
                                                        1.0 * scaleFactor),
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10.0 * scaleFactor),
                                              height: 56 * scaleFactor,
                                              child: CustomDropdown(
                                                onClick: (String option) {
                                                  tipoController.text = option;
                                                },
                                                scaleFactor: scaleFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 486 * scaleFactor,
                                        height: 133 * scaleFactor,
                                        padding: EdgeInsets.only(
                                            top: 24 * scaleFactor),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Link da contribuição',
                                                  textScaleFactor: scaleFactor,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    height: 1.2,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        blurRadius: 0,
                                                        offset: Offset(
                                                            1.0 * scaleFactor,
                                                            1.0 * scaleFactor),
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.75),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20.5 * scaleFactor),
                                                  child: Text(
                                                    '(Opcional)',
                                                    textScaleFactor:
                                                        scaleFactor,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      height: 1.2,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          blurRadius: 0,
                                                          offset: Offset(
                                                              1.0 * scaleFactor,
                                                              1.0 *
                                                                  scaleFactor),
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
                                              width: 486 * scaleFactor,
                                              height: 56 * scaleFactor,
                                              margin: EdgeInsets.only(
                                                  top: 10 * scaleFactor,
                                                  bottom: 23 * scaleFactor),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(CommonColors
                                                        .boxInsetBackground),
                                                  ),
                                                ],
                                                border:
                                                    _insetBorder(scaleFactor),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 16 * scaleFactor),
                                                child: TextFormField(
                                                  controller: linkController,
                                                  cursorColor: Colors.black,
                                                  decoration:
                                                      new InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14 * scaleFactor,
                                                    height: 1.5,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        blurRadius: 0,
                                                        offset: Offset(
                                                            1.0 * scaleFactor,
                                                            1.0 * scaleFactor),
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
                                        width: 486 * scaleFactor,
                                        height: 211 * scaleFactor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Descrição',
                                              textScaleFactor: scaleFactor,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                height: 1.2,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    blurRadius: 0,
                                                    offset: Offset(
                                                        1.0 * scaleFactor,
                                                        1.0 * scaleFactor),
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.75),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 486 * scaleFactor,
                                              height: 152 * scaleFactor,
                                              margin: EdgeInsets.only(
                                                  top: 10 * scaleFactor,
                                                  bottom: 29 * scaleFactor),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(CommonColors
                                                        .boxInsetBackground),
                                                  ),
                                                ],
                                                border:
                                                    _insetBorder(scaleFactor),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 16 * scaleFactor),
                                                child: TextFormField(
                                                  controller:
                                                      descricaoController,
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
                                                  decoration:
                                                      new InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14 * scaleFactor,
                                                    height: 1.5,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        blurRadius: 0,
                                                        offset: Offset(
                                                            1.0 * scaleFactor,
                                                            1.0 * scaleFactor),
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
                                                      ItemType.CAFE_COM_CODIGO);
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
                                                    width: 164 * scaleFactor,
                                                    height: 44 * scaleFactor,
                                                  ),
                                                  opacity: 0.5,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 2.0 * scaleFactor,
                                                    left: 2.0 * scaleFactor),
                                              ),
                                              ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 0, sigmaY: 0),
                                                  child: NineTileBox(
                                                    image: Assets.buttonImage,
                                                    tileSize: 12,
                                                    destTileSize: 12,
                                                    width: 164 * scaleFactor,
                                                    height: 44 * scaleFactor,
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              'Enviar',
                                                              textScaleFactor:
                                                                  scaleFactor,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                height: 1,
                                                                shadows: <
                                                                    Shadow>[
                                                                  Shadow(
                                                                      blurRadius:
                                                                          0,
                                                                      offset: Offset(
                                                                          1.0 *
                                                                              scaleFactor,
                                                                          1.0 *
                                                                              scaleFactor),
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
                child: CloseButtonWidget(
                    onClick: widget.onClick, scaleFactor: scaleFactor),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Border _insetBorder(double scaleFactor) {
  return Border(
      right: BorderSide(
          color: Color(CommonColors.lightBorder), width: 2.0 * scaleFactor),
      bottom: BorderSide(
          color: Color(CommonColors.lightBorder), width: 2.0 * scaleFactor),
      left: BorderSide(
          color: Color(CommonColors.darkBorder), width: 2.0 * scaleFactor),
      top: BorderSide(
          color: Color(CommonColors.darkBorder), width: 2.0 * scaleFactor));
}
