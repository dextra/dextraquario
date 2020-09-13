import 'package:dextraquario/components/card_item.dart';
import 'package:dextraquario/fish_info.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselItems extends StatefulWidget {
  final List<FishItem> items;

  CarouselItems({this.items});

  @override
  State<StatefulWidget> createState() {
    return _CarouselItemsState();
  }
}

class _CarouselItemsState extends State<CarouselItems> {
  int _current = 0;

  List<Widget> _getCarouselItems(List<FishItem> items) {
    return items
        .map(
          (item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: CardItem(fishItem: item),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _getCarouselItems(widget.items),
          options: CarouselOptions(
              height: 480,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.map((item) {
            int index = widget.items.indexOf(item);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
