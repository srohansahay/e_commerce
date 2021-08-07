import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  //const CustomBtn({Key key}) : super(key: key);

  final String? text;
  final Function()? onPressed;
  final bool? outlineBtn;
  final bool? isLoading;
  CustomBtn({ this.text,  this.onPressed,  this.outlineBtn, this.isLoading});


  @override
  Widget build(BuildContext context) {


    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;


    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        height: 50.0,
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(color: _outlineBtn ? Colors.transparent :Colors.black, border: Border.all(width: 2.0,color:  Colors.black, ), borderRadius: BorderRadius.circular(12.0) ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(text!, textAlign: TextAlign.center, style: TextStyle(
                  color: _outlineBtn ? Colors.black : Colors.amber.shade200, fontSize: 18.0
                 ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0, width: 30.0,
                    child: CircularProgressIndicator(color: Colors.amber.shade200,)),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
