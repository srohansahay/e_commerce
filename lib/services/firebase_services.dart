import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
 }

  CollectionReference productReference = FirebaseFirestore.instance.collection('menu');

  CollectionReference userReference = FirebaseFirestore.instance.collection('Users');



}