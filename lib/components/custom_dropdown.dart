import 'dart:ui';

import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  String text;
  double itemHeight;

  CustomDropdown({Key key, @required this.text, @required this.itemHeight})
      : super(key: key);

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

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    angleArrow = 90;
    paddingArrow = EdgeInsets.only(left: 0, top: 0);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    setState(() {
      widget.itemHeight = height;
    });

    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.only(
              left: xPosition, top: yPosition + height, right: xPosition),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 1,
              ),
              Material(
                elevation: 2,
                child: Container(
                  height: 7 * widget.itemHeight,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.text = 'Desafio Técnico';
                            floatingDropdown.remove();
                            angleArrow = 90;
                            paddingArrow = EdgeInsets.only(left: 0, top: 0);
                            isDropdownOpened = false;
                          });
                        },
                        child: DropDownItem.first(
                          text: 'Desafio Técnico',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.text = 'Entrevista Participação';
                            floatingDropdown.remove();
                            angleArrow = 90;
                            paddingArrow = EdgeInsets.only(left: 0, top: 0);
                            isDropdownOpened = false;
                          });
                        },
                        child: DropDownItem(
                          text: 'Entrevista Participação',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.text = 'Entrevista Avaliação Teste';
                            floatingDropdown.remove();
                            angleArrow = 90;
                            paddingArrow = EdgeInsets.only(left: 0, top: 0);
                            isDropdownOpened = false;
                          });
                        },
                        child: DropDownItem(
                          text: 'Entrevista Avaliação Teste',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.text = 'Café com código';
                            floatingDropdown.remove();
                            angleArrow = 90;
                            paddingArrow = EdgeInsets.only(left: 0, top: 0);
                            isDropdownOpened = false;
                          });
                        },
                        child: DropDownItem(
                          text: 'Café com código',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.text = 'Contribuição Comunidade';
                            floatingDropdown.remove();
                            angleArrow = 90;
                            paddingArrow = EdgeInsets.only(left: 0, top: 0);
                            isDropdownOpened = false;
                          });
                        },
                        child: DropDownItem(
                          text: 'Contribuição Comunidade',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.text = 'Artigo Blog Dextra';
                            floatingDropdown.remove();
                            angleArrow = 90;
                            paddingArrow = EdgeInsets.only(left: 0, top: 0);
                            isDropdownOpened = false;
                          });
                        },
                        child: DropDownItem(
                          text: 'Artigo Blog Dextra',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.text = 'Chapa';
                            floatingDropdown.remove();
                            angleArrow = 90;
                            paddingArrow = EdgeInsets.only(left: 0, top: 0);
                            isDropdownOpened = false;
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
        right: BorderSide(color: Color(0x5FEFCBBA), width: 2.0),
        bottom: BorderSide(color: Color(0x5FEFCBBA), width: 2.0),
        left: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 2.0),
        top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 2.0));
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
          color: Color.fromRGBO(192, 108, 76, 1),
          border: _insetBorder(),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xFFC06C4C),
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
                  widget.text,
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
                        child: Icon(Icons.play_arrow,
                            size: 24, color: Color.fromRGBO(161, 84, 48, 1))),
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
          top: isFirstItem ? Radius.zero : Radius.zero,
          bottom: isLastItem ? Radius.zero : Radius.zero,
        ),
        color: Color.fromRGBO(192, 108, 76, 1),
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
