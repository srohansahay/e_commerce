import 'dart:math';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/tabs/product_tab.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  //const HomeTab({Key key}) : super(key: key);

  FirebaseServices _firebaseServices = FirebaseServices();


  @override

  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade200,
      child: Stack(
        children:[
          FutureBuilder<QuerySnapshot>(
           future: _firebaseServices.productReference.get(),
             builder: (context, snapshot) {
               if(snapshot.hasError){
                 return Scaffold(
                   body: Center(
                     child: Text('Error: ${snapshot.error}'),
                   ),
                 );
               }
               if(snapshot.connectionState == ConnectionState.done){
                   return  ListView(
                     padding: EdgeInsets.only(top: 125.0),
                     children:  snapshot.data!.docs.map((document){
                       return GestureDetector(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ProductTab(documentID: document.id,);
                           }));
                         },
                         child: Stack(
                           children: [
                            Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12.0),
                                   gradient: SweepGradient( center: FractionalOffset.topRight,
                                     startAngle: 1,
                                     endAngle: pi*3,
                                     colors: <Color>[
                                       Colors.black,
                                       Colors.black45,
                                       Colors.black,
                                     ],
                                     stops: <double>[0.0,  0.5,  1.0],),
                                   color: Colors.grey[850],
                                 ),
                                 margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 35.0),
                                 height: 300.0,
                                 //width: 300.0,
                                   alignment: Alignment.center,
                               ),
                             Stack(
                               children: [
                                 Container(
                                   height: 240.0,
                                   width: 200.0,
                                   decoration: BoxDecoration(
                                     gradient: SweepGradient( center: FractionalOffset.topRight,
                                       startAngle: 0.0,
                                       endAngle: pi * 2,
                                       colors: <Color>[
                                         Color(0xFFFBBC05), // yellow
                                         Colors.black87,
                                         Color(0xFFFBBC05),
                                       ],
                                       stops: <double>[0.0,  0.75,  1.0],),
                                     borderRadius: BorderRadius.circular(12.0),
                                   ),
                                   margin: EdgeInsets.only(left: 100.0),
                                 ),
                                 Container(
                                   height: 225.0,
                                   width: 150.0,
                                   margin: EdgeInsets.only(left: 125.0, top: 8.0),
                                   child: ClipRRect(
                                       borderRadius: BorderRadius.circular(12.0),
                                     child: Image.network(
                                       "${document['image'][0]}", fit: BoxFit.fill, ),
                                   ),
                                 ),
                                 Container(
                                   margin: EdgeInsets.only(top: 246.0, left: 50.0, right: 50.0),
                                   child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Container( width: 180.0,
                                           child: Text('${document['title']}'.substring(0,18)+'....', style: TextStyle(color:Colors.amber.shade400, fontSize: 22.0, fontWeight: FontWeight.w600 ),)),
                                       Text('Rs.${document['price']}', style: TextStyle(color:Colors.green, fontSize: 22.0, fontWeight: FontWeight.w500 )),
                                     ],
                                   ),
                                 )
                               ],),
                           ],
                         ),
                       );
                     }).toList()
                   );
               }
               return Shimmer.fromColors(
                 baseColor: Colors.amber.shade200,
                 highlightColor: Colors.white24,
                 child: Scaffold(
                   backgroundColor: Colors.amber.shade200,
                   body: Shimmer.fromColors(
                       baseColor: Colors.grey.shade800,
                       highlightColor: Colors.amber.shade200,
                       child: Center(child: CircularProgressIndicator(color: Colors.yellow[700],))),
                   ),

               );
             }),
         CustomActionBar(title: 'Home',  hasbackArrow: false, hastitle: true)]
      ),
    );
  }
}
