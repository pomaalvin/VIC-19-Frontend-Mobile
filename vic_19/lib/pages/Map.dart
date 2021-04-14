

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geojson/geojson.dart' as geoL;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';
import 'package:vic_19/bloc/states/MapState.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/mapComponents/ExpandButton.dart';
import 'package:vic_19/components/mapComponents/FilterButton.dart';
import 'package:vic_19/components/mapComponents/GraphicsButton.dart';
import 'package:vic_19/components/mapComponents/TitleMap.dart';
import 'package:vic_19/util/BoliviaMap.dart';
import 'package:vic_19/util/MyBehavior.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _mapStyle;
  GoogleMapController mapController;
  Size size;
  Set <Marker> markers;
  int type=0;
  List<bool> filters=[true,false,false,false];
  ScrollController _scrollController;
  bool graphics=false;
  String title="";
  double zoom=5;
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _scrollController=ScrollController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    size=Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
    return BlocBuilder<MapBLoc,MapState>(
          builder: (context,state){
            print(state);
            if(state is MaploadMarkersOkState){
              markers=state.props[1];
              zoom=state.props[0];
              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: state.props[3],

                zoom: state.props[0],
              )));
              type=state.props[2];
            }
            if(state is MapFilterOkState){
              markers=state.props[0];
              filters=state.props[1];
            }
            if(state is MapSelectCountryState){
              Location country=state.props[0];
              title=country.name;
            }
            if(state is MapGraphicsOkState){
                _scrollController.animateTo(_scrollController.position.maxScrollExtent,curve: Curves.decelerate,duration: Duration(milliseconds: 1000));
                graphics=true;

            }
            if(state is MapMainMapOkState){
              _scrollController.animateTo(_scrollController.position.minScrollExtent,curve: Curves.decelerate,duration: Duration(milliseconds: 1000));
              graphics=false;

            }
            return Container(
              child: Stack(
                children: [
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      controller: _scrollController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: size.height,
                          width:size.width,
                          child:
                                 Stack(
                                   children: [GoogleMap(
                                       zoomControlsEnabled: false,
                                       minMaxZoomPreference: MinMaxZoomPreference(zoom-0.5,zoom+0.5),
                                       cameraTargetBounds: CameraTargetBounds(
                                         LatLngBounds
                                           (northeast: LatLng(-10.2256651,-59.0455838),southwest: LatLng(-20.2256651,-68.0455838))
                                       ),

                                       initialCameraPosition: _kGooglePlex,
                                       markers: markers,
                                       trafficEnabled: false,
                                       buildingsEnabled: false ,
                                       compassEnabled: false,
                                       indoorViewEnabled: false,
                                       liteModeEnabled: false,
                                       mapToolbarEnabled: false,
                                       myLocationButtonEnabled: false,
                                       myLocationEnabled: false,
                                       rotateGesturesEnabled: false,
                                       tiltGesturesEnabled: false,



                                       onMapCreated: (GoogleMapController controller){
                                         mapController=controller;
                                         mapController.setMapStyle(_mapStyle);
                                         BlocProvider.of<MapBLoc>(context).add(GetCountriesEvent(context));
                                       }),mapController==null?Container(width: size.width,height: size.height,color:color1):Container()],
                                 ),
                        ),
                        SizedBox(
                          height: size.height,
                          width:size.width,
                          child: Column(
                            children: [
                              SizedBox(height: 40,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                    Positioned(
                        top: MediaQuery.of(context).padding.top+size.height*0.12,
                        child: AnimatedOpacity(
                            opacity: graphics?0:1,
                            duration: Duration(milliseconds: 500),
                            child: SizedBox(
                          width: size.width,
                          height: size.height*0.05,
                          child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: type==0||type==1?size.width-size.width*0.1:(size.width*0.35*4-size.width*0.05),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: type==0||type==1?[
                                      FilterButton(size.width*0.3, 10,"Ubicación", 0, color4, Icons.location_on,filters[0])]:[
                                      FilterButton(size.width*0.3, 10,"Ubicación", 0, color4, Icons.location_on,filters[0]),
                                      SizedBox(width: size.width*0.05,),

                                      FilterButton(size.width*0.3, 10,"Hospitales", 1, color6, Icons.local_hospital,filters[1]),
                                      SizedBox(width: size.width*0.05,),

                                      FilterButton(size.width*0.3, 10,"Farmacias", 2, color3, Icons.local_pharmacy,filters[2]),
                                      SizedBox(width: size.width*0.05,),

                                      FilterButton(size.width*0.3, 10,"Albergues", 3, color2, Icons.local_hotel,filters[3])],
                                  ),
                                )
                              ],
                            ),
                          )
                        )
                  ),
                    ),
                  Positioned(
                      top: 0,
                      child: Container(
                          width: size.width,
                          height: size.height*0.2,
                          child: Center(
                            child: TitleMap(size.width*0.6,size.height*0.05,title),
                          )
                      )
                  ),
                  Positioned(
                    right: size.width*0.03,
                    bottom: size.height*0.085,
                    child: AnimatedOpacity(
                        opacity: title!=""&&!graphics?1:0,
                        duration: Duration(milliseconds: 300),
                        child: GraphicsButton(size.height*0.05,size.height*0.05)),
                  ),
                  Positioned(
                    left: size.width*0.03,
                    bottom: size.height*0.115,
                    child: AnimatedOpacity(
                        opacity: title!=""&&!graphics?1:0,
                        duration: Duration(milliseconds: 300),
                        child: ExpandButton(size.height*0.05,size.height*0.05)),
                  ),
                  state is MapLoadingMarkersState || state is MapInitialState?Loading():Container()
                ],
              ),
            );
          },
        );
  }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-16.2256651,-65.0455838),
    zoom: 4.5,
  );

}


