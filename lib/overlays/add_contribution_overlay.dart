import 'dart:ui';

import 'package:dextraquario/components/custom_dropdown.dart';
import 'package:flame/widgets/nine_tile_box.dart';
import 'package:flutter/material.dart';

import '../assets.dart';

class AddContributionScreenOverlay extends StatelessWidget {
  final Function onClick;
  AddContributionScreenOverlay({this.onClick});

  final descricaoController = TextEditingController();
  final linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                                              itemHeight: 56,
                                              text: 'Tipo de contribuições',
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
                                                  color: Color(0xFFC06C4C),
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
                                                  color: Color(0xFFC06C4C),
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
                                              .validate()) {}
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
              child: Padding(
                padding: const EdgeInsets.all(44.0),
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset('images/close_button.png',
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                      padding: EdgeInsets.only(top: 2.0, left: 0.0),
                    ),
                    GestureDetector(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Image.asset('images/close_button.png'),
                      ),
                      onTap: () {
                        onClick();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Border _insetBorder() {
  return Border(
      right: BorderSide(color: Color(0x5FEFCBBA), width: 2.0),
      bottom: BorderSide(color: Color(0x5FEFCBBA), width: 2.0),
      left: BorderSide(color: Color(0x5A000000), width: 2.0),
      top: BorderSide(color: Color(0x5A000000), width: 2.0));
}
