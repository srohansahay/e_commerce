import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/tabs/product_tab.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  //const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      body: Stack(
        children: [
          CustomActionBar(hasbackArrow: true, title: 'Cart', hastitle: true,),
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userReference.doc(_firebaseServices.getUserId()).collection('Cart').get(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }
                if(snapshot.connectionState== ConnectionState.done){
                  return  ListView(
                      padding: EdgeInsets.only(top: 125.0),
                      children:  snapshot.data!.docs.map((document){
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ProductTab(documentID: document.id);
                            }));
                          },
                          child: FutureBuilder<DocumentSnapshot>(
                            future: _firebaseServices.productReference.doc(document.id).get(),
                            builder: (context, productsnapshot) {
                              if(productsnapshot.hasError){
                                return Container(
                                  child: Text('${productsnapshot.error}'),
                                );
                              }
                              if(productsnapshot.connectionState == ConnectionState.done){
                                Map<String, dynamic> _productMap = productsnapshot.data!.data() as Map<String, dynamic>;
                                return Container(
                                  margin: EdgeInsets.all(8.0),
                                  height: 100.0,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), gradient: SweepGradient( center: FractionalOffset.topRight,
                                    startAngle: 0.0,
                                    endAngle: pi * 2,
                                    colors: <Color>[
                                      Colors.black12, // blue

                                      Color(0xFFFBBC05), // yellow

                                      Colors.black, // blue again to seamlessly transition to the start
                                    ],
                                    stops: <double>[0.0,  0.5,  1.0],),),
                                  child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.network('${_productMap['image'][0]}'),
                                        margin: EdgeInsets.only(left: 5.0),
                                        height: 60.0,
                                        width: 60.0,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 8.0, right: 3.0),
                                           height: 90.0,
                                           width: 220.0,
                                          child: Text('${_productMap['title']}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),)),
                                      Container(
                                        child: Text('Rs. ${_productMap['price']}', style: TextStyle(fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.w600, ),),
                                        height: 50.0,
                                        width: 80.0,
                                      )
                                    ],
                                  ),);
                              }
                              return
                                Shimmer.fromColors(
                                  baseColor: Colors.amber.shade200,
                                  highlightColor: Colors.white24,
                                  child: Container(
                                  color: Colors.amber.shade200,
                                  child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade800,
                                  highlightColor: Colors.amber.shade200,
                                  child: Center(child: CircularProgressIndicator(color: Colors.yellow[700],))),
                              ),
                                );

                            },
                          )
                        );
                      }).toList(),
                  );
                }
                return Scaffold();


          })
        ],
      ),

    );
  }
}
