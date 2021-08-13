import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/cart_page.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  //const CustomActionBar({Key key}) : super(key: key);

  String? title;
  bool? hasbackArrow;
  bool? hastitle;

  CustomActionBar({this.title, this.hasbackArrow, this.hastitle});

  @override
  Widget build(BuildContext context) {

    bool _hasbackArrow = hasbackArrow!;
    bool _hastitle = hastitle!;

    FirebaseServices _firebaseServices = FirebaseServices();

    CollectionReference _userReference = FirebaseFirestore.instance.collection('Users');



    return Container(

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade200,
            Colors.amber.shade200.withOpacity(0)
          ],
              begin: Alignment(0,0),
              end: Alignment(0,1),
        )
      ),
      padding: EdgeInsets.only(left: 24.0, top: 56.0, right: 24.0, bottom: 42.0),
      child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasbackArrow)
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container( width: 42.0,
              height: 42.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
            child: Image(image: AssetImage('assets/images/backarrow.png'),color: Colors.white,),),
          ),
          //DrawerTab(),

          if(_hastitle)
          Text(title!, style: Constants.boldHeading,),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CartPage();
              }));
            },
            child: Container(
                width: 50.0,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _userReference.doc(_firebaseServices.getUserId()).collection('Cart').snapshots(),
                    builder: (context, snapshot){
                    int _totalItems = 0;
                    if(snapshot.connectionState == ConnectionState.active){
                      List _documents = snapshot.data!.docs;
                      _totalItems = _documents.length;

                    }
                        return Container(
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 30.0, right: 0.0, top: 3.0),
                                  decoration: BoxDecoration(
                                    //color: Colors.amber,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Text('$_totalItems', style: TextStyle(fontSize:18.0, fontWeight: FontWeight.w600, color: Colors.amber ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                                  child: IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart), color: Colors.amber[800], iconSize: 20.0,),
                                ),
                              ],
                            ));
                    },
                 ),
            ),
          )
        ],
      ),
    );
  }
}
