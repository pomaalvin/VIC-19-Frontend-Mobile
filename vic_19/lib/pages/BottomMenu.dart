import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Pages/Map.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/repositories/MapRepository.dart';
import 'package:vic_19/bloc/states/MapState.dart';
import 'package:vic_19/components/bottomNav/MapButtonAnimated.dart';
import 'package:vic_19/components/bottomNav/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/pages/TablesPage.dart';

import '../PaletteColor.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  static List<Widget> pages;



  int _selectedIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pages=[TablesPage(),MapPage(),Container()];
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create:(context)=>MapBLoc(MapRepository()),
    child: BlocBuilder<MapBLoc,MapState>(
        builder: (context, state)
        {
          return Stack(
              children: [
              ScrollConfiguration(
              behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.right,
            color: color1.withOpacity(0),

            child: IndexedStack(
                index:_selectedIndex,
                children: pages
            ),
          ),
        ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height*0.07,
                width: size.width,
                child: CurvedNavigationBar(
                        index: _selectedIndex,
                        items: [Icon(
                          Icons.table_chart_rounded,
                          size: size.height*0.04,
                          color: _selectedIndex==0?color1:color5,
                        ),
                          Icon(
                            Icons.public_rounded,
                            size: size.height*0.04,
                            color: _selectedIndex==1?color1:color5,
                          ),
                          Icon(
                            Icons.list_alt_rounded,
                            size: size.height*0.04,
                            color: _selectedIndex==2?color1:color5,
                          ),
                        ],
                        onTap: (index){
                          if(index==_selectedIndex){
                            print("no");
                          }
                          else{
                            print("si");
                            setState(() {
                              _selectedIndex = index;
                            });
                          }

                        },

                        buttonBackgroundColor: color2,
                        lock:  state is MapGraphicsOkState?true:false,

                        backgroundColor: color1,
                        height: size.height*0.07,
                        color: color1,
                        animationDuration: const Duration(milliseconds: 300),
                      ),
              ),
            ),
            state is MapGraphicsOkState&&_selectedIndex==1?Positioned(
                  bottom: size.height*0.028,
                  left: size.width*0.5-size.height*0.03,
                  child: AnimatedOpacity(
                      opacity: state is MapGraphicsOkState&&_selectedIndex==1?1:0,
                      duration: Duration(milliseconds: 300),
                      child: MapButtonAnimated(size.height*0.06,size.height*0.01)),

                ):Container()


      ],
        );}
    )
    )
    );
  }
}

