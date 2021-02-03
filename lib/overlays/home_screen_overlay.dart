import 'dart:ui';

import 'package:flutter/material.dart';

class HomeScreenOverlay extends StatelessWidget {
  HomeScreenOverlay();

  @override
  Widget build(context) {
    return Stack(
      children: [
        // Painel do ranking esquerdo
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 586),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.asset('images/ranking_left_pannel72px.png'),
                          Container(
                            padding: EdgeInsets.only(top: 14, left: 27),
                            child: Image.asset('images/silver_medal.png'),
                          ),
                        ],
                      ),
                      Container(
                        child:
                            Image.asset('images/ranking_center_panel72px.png'),
                      ),
                      Container(
                        child:
                            Image.asset('images/ranking_center_panel72px.png'),
                      ),
                      Container(
                        child:
                            Image.asset('images/ranking_center_panel72px.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Painel do ranking direito
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 586),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.asset('images/ranking_center_pannel72px.png'),
                          Container(
                            padding: EdgeInsets.only(top: 14, right: 0),
                            child: Image.asset('images/bronze_medal.png'),
                          ),
                        ],
                      ),
                      Container(
                        child:
                            Image.asset('images/ranking_center_panel72px.png'),
                      ),
                      Container(
                        child:
                            Image.asset('images/ranking_center_panel72px.png'),
                      ),
                      Container(
                        child:
                            Image.asset('images/ranking_right_panel72px.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Painel do ranking do meio
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset('images/ranking_left_pannel.png'),
                    Container(
                      padding: EdgeInsets.only(top: 8, left: 29),
                      child: Image.asset('images/gold_medal.png'),
                    ),
                  ],
                ),
                Container(
                  child: Image.asset('images/ranking_center_panel.png'),
                ),
                Container(
                  child: Image.asset('images/ranking_center_panel.png'),
                ),
                Container(
                  child: Image.asset('images/ranking_right_panel.png'),
                ),
              ],
            ),
          ),
        ),
        // Botões de configurações e adicionar
        Container(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 44, right: 44),
                    child: Image.asset('images/gear.png')),
                Container(
                    padding: EdgeInsets.only(bottom: 111.0, right: 89.0),
                    child: Image.asset('images/add_button.png'))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
