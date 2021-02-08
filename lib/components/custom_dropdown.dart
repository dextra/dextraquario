import 'dart:ui';

import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../common.dart';
import '../services/contribution_service.dart';

class CustomDropdown extends StatefulWidget {
  final Function onClick;
  CustomDropdown({Key key, this.onClick}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  OverlayEntry floatingDropdown;
  double angleArrow;
  EdgeInsets paddingArrow;
  String text = 'Tipo de Contribuição';
  double itemHeight;

  @override
  void initState() {
    super.initState();
    actionKey = LabeledGlobalKey(text);
    angleArrow = 90;
    paddingArrow = EdgeInsets.only(left: 0, top: 0);
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      height = renderBox.size.height;
      itemHeight = height;
      width = renderBox.size.width;
      xPosition = offset.dx;
      yPosition = offset.dy;
    });
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.only(
            left: xPosition,
            top: yPosition + height,
            right: xPosition,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 1),
              Material(
                elevation: 2,
                child: Container(
                  height: 7 * itemHeight,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setDropdownClickState('Desafio Técnico');
                          });
                        },
                        child: DropDownItem.first(
                          text: 'Desafio Técnico',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setDropdownClickState('Entrevista Participação');
                          });
                        },
                        child: DropDownItem(
                          text: 'Entrevista Participação',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setDropdownClickState('Entrevista Avaliação Teste');
                          });
                        },
                        child: DropDownItem(
                          text: 'Entrevista Avaliação Teste',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setDropdownClickState('Café com Código');
                          });
                        },
                        child: DropDownItem(
                          text: 'Café com código',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setDropdownClickState('Contribuição Comunidade');
                          });
                        },
                        child: DropDownItem(
                          text: 'Contribuição Comunidade',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setDropdownClickState('Artigo Blog Dextra');
                          });
                        },
                        child: DropDownItem(
                          text: 'Artigo Blog Dextra',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setDropdownClickState('Chapa');
                          });
                        },
                        child: DropDownItem.last(
                          text: 'Chapa',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Border _insetBorder() {
    return Border(
        right: BorderSide(color: Color(CommonColors.lightBorder), width: 2.0),
        bottom: BorderSide(color: Color(CommonColors.lightBorder), width: 2.0),
        left: BorderSide(color: Color(CommonColors.darkBorder), width: 2.0),
        top: BorderSide(color: Color(CommonColors.darkBorder), width: 2.0));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
            angleArrow = 90;
            paddingArrow = EdgeInsets.only(left: 0, top: 0);
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
            angleArrow = 270;
            paddingArrow = EdgeInsets.only(left: 4, top: 0);
          }

          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: CommonColors.lightBackground,
          border: _insetBorder(),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(CommonColors.boxInsetBackground),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1, 1),
                            color: Color.fromRGBO(0, 0, 0, 0.75)),
                      ],
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Transform.rotate(
                angle: angleArrow * math.pi / 180,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.play_arrow,
                        size: 24,
                        color: Color.fromRGBO(0, 0, 0, 0.75),
                      ),
                    ),
                    Container(
                      padding: paddingArrow,
                      child: Icon(
                        Icons.play_arrow,
                        size: 24,
                        color: CommonColors.darkBackground,
                      ),
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

  void setDropdownClickState(String option) {
    widget.onClick(option);
    text = option;
    floatingDropdown.remove();
    angleArrow = 90;
    paddingArrow = EdgeInsets.only(left: 0, top: 0);
    isDropdownOpened = false;
  }
}

class DropDownItem extends StatelessWidget {
  final String text;
  final bool isFirstItem;
  final bool isLastItem;

  const DropDownItem(
      {Key key, this.text, this.isFirstItem = false, this.isLastItem = false})
      : super(key: key);

  factory DropDownItem.first({String text, bool isSelected}) {
    return DropDownItem(
      text: text,
      isFirstItem: true,
    );
  }

  factory DropDownItem.last({String text, bool isSelected}) {
    return DropDownItem(
      text: text,
      isLastItem: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.zero,
          bottom: Radius.zero,
        ),
        color: CommonColors.lightBackground,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1,
              fontWeight: FontWeight.w400,
              shadows: <Shadow>[
                Shadow(offset: Offset(1, 1)),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}