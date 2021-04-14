import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/PaletteColor.dart';


class LineTitles{
  static getTitleData(List<String> _titles,List<String> _titlesY){
    // getTitleData(this._titles);
    return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 10,
          margin: 15,
          getTextStyles: (value)=> const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13
          ),
          getTitles: (value){
            switch (value.toInt()){
              case 2:
                return _titles[0];
              case 4:
                return _titles[1];
              case 6:
                return _titles[2];
              case 8:
                return _titles[3];
              case 10:
                return _titles[4];
              // case 12:
              //   return _titles[5];
              // case 14:
              //   return _titles[6];
              // case 16:
              //   return _titles[7];
            }
            return '';
          }
        ),
      leftTitles: SideTitles(
        showTitles: true,
          // reservedSize: 10,
          margin: 20,
          getTextStyles: (value)=> const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
          getTitles: (value){
            switch (value.toInt()){
              case 0:
                return _titlesY[0];
              case 1:
                return _titlesY[1];
              case 2:
                return _titlesY[2];
              case 3:
                return _titlesY[3];
              case 4:
                return _titlesY[4];
              case 5:
                return _titlesY[5];
              case 6:
                return _titlesY[6];
              // case 7:
              //   return _titlesY[7];
            }
            return '';
          }
      ),
    );
  }

}