import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/home_page.dart';
import 'package:e_commerce/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shimmer/shimmer.dart';

class LandingPage extends StatefulWidget {
  //const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {

          if(snapshot.hasError){
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }
          // connection initialized - firebase app is running
          if(snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamsnapshot){
                  if(streamsnapshot.hasError){
                    return Scaffold(
                      body: Center(
                        child: Text('Error: ${streamsnapshot.error}'),
                      ),
                    );
                  }
                  if(streamsnapshot.connectionState == ConnectionState.active){
                    Object? _user = streamsnapshot.data;

                    if(_user == null){
                      return LoginPage();
                    } else {
                      return HomePage();
                    }
                  }

                  return Scaffold(
                    backgroundColor: Colors.amber.shade200,
                    body: Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.amber.shade200,
                          highlightColor: Colors.black12,
                          child: Text('Checking Authentication', style: Constants.regularHeading)),
                    ),
                  );
                });
          }
          // connecting to firebase - Loading
          return Scaffold(
            backgroundColor: Colors.amber.shade200,
            body: Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.amber.shade200,
                  highlightColor: Colors.black12,
                  child: Text('Initializing App', style: Constants.regularHeading)),
            ),
          );
        }
    );
  }
}
