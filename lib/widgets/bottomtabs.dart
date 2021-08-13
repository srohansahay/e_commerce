import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  //const BottomTab({Key key}) : super(key: key);
  int isSelectedtab ;
  Function(int)? onTabPressed ;

  BottomTab({ required this.isSelectedtab, this.onTabPressed});


  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {


  late int _isSelectedtab ;


  @override
  Widget build(BuildContext context) {

   _isSelectedtab = widget.isSelectedtab ;


    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
        boxShadow: [BoxShadow(spreadRadius: 1.0, blurRadius: 30.0, color: Colors.black.withOpacity(0.05))],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(imagePath: "assets/images/home.png",
            isSelected: _isSelectedtab == 0 ? true : false,
            onPressed: () { widget.onTabPressed!(0);}, ),
          BottomTabBtn(imagePath: "assets/images/search.png",
            isSelected:_isSelectedtab == 1 ? true : false,
            onPressed: () { widget.onTabPressed!(1);}, ),
          BottomTabBtn(imagePath: "assets/images/bookmark.png",
            isSelected : _isSelectedtab == 2 ? true : false,
            onPressed: () { widget.onTabPressed!(2);}, ),
          BottomTabBtn(imagePath: "assets/images/exit.png",
            isSelected:_isSelectedtab == 3 ? true : false,
            onPressed: () {
              widget.onTabPressed!(3);
            setState(() {
            FirebaseAuth.instance.signOut();});
          }
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  //const BottomTabBtn({Key key}) : super(key: key);

  String? imagePath;
  bool isSelected;
  Function()? onPressed;
  BottomTabBtn({this.imagePath, required this.isSelected,  this.onPressed});

  @override
  Widget build(BuildContext context) {

    bool _isSelected = isSelected ;

    return GestureDetector
      ( onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.0, color: _isSelected ?  Theme.of(context).accentColor : Colors.transparent),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),

          child: Image(
            image: AssetImage(imagePath ?? "assets/images/home.png"),
            width: 26.0,
            height: 26.0,
            color: _isSelected ? Theme.of(context).accentColor : Colors.amber.shade200,

          )
        ),
      ),
    );
  }
}
