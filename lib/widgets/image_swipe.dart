import 'dart:math';

import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  //const ImageSwipe({Key key}) : super(key: key);

  List? imageList;

  ImageSwipe({this.imageList});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {

  @override

  int _selectedPage = 0;


  Widget build(BuildContext context) {
    return Container(
      height: 532.0,
           child: PageView(
             onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
               },
               children: [ for(var i=0; i< widget.imageList!.length; i++)
                 Column(
                   children: [
                     Container(margin:EdgeInsets.only(top: 100.0, left: 10.0, right: 10.0), width: 400.0, height: 400.0, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),
                     gradient: SweepGradient( center: FractionalOffset.topRight,
                       startAngle: 0.0,
                       endAngle: pi * 2,
                       colors: <Color>[
                         Color(0xFFFBBC05),
                         Colors.black87,
                         Color(0xFFFBBC05),
                       ],
                       stops: <double>[0.0,  0.25,  1.0],),
                     ),
                      child: Stack(
                        children: [
                          Center(
                              child: Container(
                                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                                 // width: 200.0,
                                  height: 300.0,
                                  child: ClipRRect(borderRadius: BorderRadius.circular(12.0),child: Image.network('${widget.imageList![i]}',))),
                            ),
                        ],
                      )),
                     AnimatedContainer(
                       duration: Duration(milliseconds: 300),
                       curve: Curves.easeOutCubic,
                       margin: EdgeInsets.only(top: 20.0, left: 154.0, right: 154.0),
                       child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [ for(var i=0; i < widget.imageList!.length; i++)
                           Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),color: Colors.black.withOpacity(0.7),),
                             height: 12.0, width: _selectedPage == i ? 36.0 : 12.0,),
                         ],
                       ),
                     )],
                 ),]
        ),
         );

  }
}
