import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

class ExpandButton extends StatelessWidget {
  double _width;
  double _height;
  int _type;
  bool _activo;
  ExpandButton(this._width, this._height,this._type,this._activo);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
              minWidth: _width,
              height: _height,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_height*0.2),
                  side: BorderSide(color: color5.withOpacity(0),width: 1)
              ),
              color: color5.withOpacity(0.5),
              child:  Center(
                child:
                Icon(
                  _type==1?Icons.fullscreen_rounded:Icons.fullscreen_exit,
                  color: color1,
                  size: _width,
                ),
              ),
              onPressed: (){
                if(_activo){
                  BlocProvider.of<MapBloc>(context).add(MapExpandEvent(context,_type));
                }
              }
          );
  }
}
