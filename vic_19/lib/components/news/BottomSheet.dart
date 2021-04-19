import 'package:flutter/material.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/util/MyBehavior.dart';

import '../../PaletteColor.dart';
class CardBottomSheet extends StatelessWidget {
  double _radius;
  // Radius _radius=10.0 as Radius;
  double _height;
  News _news;
  Color _color;
  Color _background;
  CardBottomSheet(this._radius, this._height, this._news, this._color,this._background);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
        )
      ),
      child: Column(
        children: [
          Container(
            height: _height*0.3,
            decoration: BoxDecoration(
                // color: color2,
                image: DecorationImage(
                    image: NetworkImage(_news.urlImage),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_radius),
                  topRight: Radius.circular(_radius),
                )
            ),
          ),
          Container(
            height: _height*0.7,
            padding: EdgeInsets.all(_height*0.02),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  Text(_news.title,style: TextStyle(color: _color,fontSize: _height*0.04,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Text(_news.content,style: TextStyle(color: color5,fontSize: _height*0.025),),
                  SizedBox(height: 10,),
                  Text(_news.source,style: TextStyle(color: _color,fontSize: _height*0.025),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}