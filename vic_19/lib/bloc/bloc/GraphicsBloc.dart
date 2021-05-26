

import 'package:bloc/bloc.dart';
import 'package:vic_19/bloc/events/GraphicsEvent.dart';
import 'package:vic_19/bloc/repositories/GraphicsRepository.dart';
import 'package:vic_19/bloc/states/GraphicsState.dart';

class GraphicsBloc extends Bloc<GraphicsEvent,GraphicsState>{
   GraphicsRepository _graR;
  GraphicsBloc(this._graR);
 @override
  GraphicsState get initialState => GraphicsInitialState();

 @override
  Stream<GraphicsState> mapEventToState(GraphicsEvent event) async* {
   if(event is ChangeActiveDataGraphicEvent){
     try{
       yield LoadingGraphicsState();
       print(event.props);
       _graR.changeActiveDataGraphic(event.props[0]);
       yield ChangeActiveDataGraphicState(_graR.activeDataGraphic,_graR.listPointGraphic,_graR.intX,_graR.intY,_graR.minY,_graR.xLabelGraphics);
     }
     catch(e){
       print("pasa lo otro");print(e);}
   }
   else if(event is GetDataGraphicEvent){
     try{
       yield LoadingGraphicsState();
       _graR.selectLocation=event.props[1];
       await _graR.getAllDataLocation(event.props[0]);
       yield GetDataGraphicsOkState(_graR.locationData,_graR.activeDataGraphic,_graR.listPointGraphic,_graR.intX,_graR.intY,_graR.minY,_graR.xLabelGraphics);
     }
     catch(e){
       print("pasa lo otro");print(e);}
   }
   else if(event is ChangeDateDataGraphicEvent){
     try{
       yield LoadingGraphicsState();
       await _graR.getAllDataLocation(event.props[0]);
       yield GetDataGraphicsOkState(_graR.locationData,_graR.activeDataGraphic,_graR.listPointGraphic,_graR.intX,_graR.intY,_graR.minY,_graR.xLabelGraphics);
     }
     catch(e){
       print("pasa lo otro");print(e);}
   }
   else if(event is ChangeActiveChartEvent){
     try{
       yield LoadingGraphicsState();
       _graR.getChartIndex(event.props[0]);
       yield ChangeActiveChartState(_graR.activeChart);
     }
     catch(e){
       print("pasa lo otro");print(e);}
   }
   else if (event is DownloadChartsEvent){
     _graR.capturePng(event.props[0]);
   }
  }
}