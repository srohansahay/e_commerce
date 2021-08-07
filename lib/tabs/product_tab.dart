import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/services/firebase_services.dart';
import 'package:e_commerce/widgets/custom_actionbar.dart';
import 'package:e_commerce/widgets/image_swipe.dart';
import 'package:e_commerce/widgets/sizes_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';

class ProductTab extends StatefulWidget {
  //const ProductTab({Key key}) : super(key: key);
  final String? documentID;

  ProductTab({this.documentID});



  @override
  _ProductTabState createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {

  FirebaseServices _firebaseServices = FirebaseServices();
  Color color1 = Colors.amber.shade200;

  Future<void>? _addtoCart() {
    return _firebaseServices.userReference.doc(_firebaseServices.getUserId()).collection("Cart").doc(widget.documentID).set(
      {
        'size': _selectedSize ?? null,
      }
    );
  }

  Future<void>? _addtoSaved() {
    return _firebaseServices.userReference.doc(_firebaseServices.getUserId()).collection("Saved").doc(widget.documentID).set(
        {
          'size': _selectedSize ?? null,
        }

    );
  }

   String? _selectedSize;
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      body: Stack(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: _firebaseServices.productReference.doc(widget.documentID).get(),
              builder: (context, snapshot){
                 if(snapshot.hasError){
                   return Scaffold(
                     body: Center(
                       child: Text('Error: ${snapshot.error}'),
                     ),
                   );
                 }
                 if(snapshot.connectionState == ConnectionState.done){
                   Map<String, dynamic> documentData = snapshot.data!.data() as Map<String, dynamic>;
                   SnackBar _snackBar = SnackBar(content: Text('${documentData['title']}'+' added to Cart'));
                   SnackBar _1snackBar = SnackBar(content: Text('${documentData['title']}'+' added to Saved Items'));
                   List imageList = documentData['image'];
                   List? sizeList = documentData['sizes'];
                   return ListView(
                     children: [
                       Container( width: 500.0, alignment: Alignment.center,
                           child: ImageSwipe(imageList: imageList)),
                       Container(child: Text('${documentData['title']}', style:  TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w600),), padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),),
                       Container(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Rs. ${documentData['price']}', style: TextStyle(color: Colors.red, fontSize: 27.0, fontWeight: FontWeight.w500),),
                           GestureDetector(
                             onTap: () async {
                               await _addtoSaved();
                               print('Added to saved');
                               setState(() {
                                 color1 = Colors.amber;
                               });
                               ScaffoldMessenger.of(context).showSnackBar(_1snackBar);
                             },
                             child: Container(
                               margin: EdgeInsets.only(right: 10.0),
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: color1,),
                               height: 60.0,
                               child: Image(
                                 image: AssetImage('assets/images/bookmark.png'),
                               ),
                             ),
                           ),
                           ],
                         ),padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                       ),
                       Container(child: Text('${documentData['description']}', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w300)),padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0) ),
                       if(documentData['category'] == "men's clothing" || documentData['category'] == "women's clothing" )
                         Sizeswidget(sizeList: sizeList, selectSize: (size) {
                                          _selectedSize = size;
                         } ,),
                       GestureDetector(
                         onTap: () async {
                              await _addtoCart();
                              print('Added to cart');
                              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                            },
                         child: Container(
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),  color: Colors.amber.shade400,),
                           margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                           padding: EdgeInsets.all(10.0),
                           child: Text('Add to Cart', textAlign: TextAlign.center,style: Constants.boldHeading,),
                         ),
                       )
                     ],
                    );
                   };
                return 
                   Shimmer.fromColors(
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
          CustomActionBar(hasbackArrow: true, hastitle: false),
        ],
      )
    );
  }
}
