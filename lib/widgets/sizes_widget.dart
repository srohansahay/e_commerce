import 'package:flutter/material.dart';

class Sizeswidget extends StatefulWidget {
  //const Sizeswidget({Key key}) : super(key: key);

  List? sizeList;
  Function(String)? selectSize;
  Sizeswidget({this.sizeList, this.selectSize});

  @override
  _SizeswidgetState createState() => _SizeswidgetState();
}

class _SizeswidgetState extends State<Sizeswidget> {
  @override

  int _selectedSize = 0;

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 280.0),
              child: Text('Sizes:',style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600 ),)),
          Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 55.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for(var i=0; i< widget.sizeList!.length; i++)
                   GestureDetector(
                     onTap: (){
                       widget.selectSize!('${widget.sizeList![i]}');
                       setState(() {
                           _selectedSize = i;
                       });
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10.0),color: _selectedSize == i ? Colors.black : Colors.amber
                       ),
                       margin: EdgeInsets.all(4.0),

                       height: 45.0,
                       width: 45.0,
                       child: Center(child: Text('${widget.sizeList![i]}', style: TextStyle(fontSize: 18.0, color: _selectedSize == i ? Colors.amber.shade200 : Colors.black ),)),
                     ),
                   )
                  ],
            ),
          ),
        ],
      )
    );
  }
}
