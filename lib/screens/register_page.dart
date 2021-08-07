import 'package:e_commerce/screens/login_page.dart';
import 'package:e_commerce/widgets/customBtn.dart';
import 'package:e_commerce/widgets/custom_inputText.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  //const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
 Future<void> _alertDialogueBuilder(String error) async{

   return showDialog(context: context,barrierDismissible: false, builder: (context) {
     return AlertDialog(
       contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
       title: Text("Error"),
       content: Container(
         child: Text(error),
       ),
       actions: [TextButton(onPressed:() { Navigator.pop(context);}, child: Text('Retry'))],
     );
   });
 }

 Future<String?> _registerwithEmailandPassword() async {

   try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: _registeremail,
         password: _registerpassword
     );
      return null;
   } on FirebaseAuthException catch(e){
     if (e.code == 'weak-password') {
       return 'The password provided is too weak.';
     } else if (e.code == 'email-already-in-use') {
       return 'The account already exists for that email.';
     }
     return e.message;
   } catch (e) {
     return e.toString();
   }
 }

 void _Submitform() async {

   setState(() {
      hereLoading = true;
    });

   String? onRegisterfeedback = await _registerwithEmailandPassword() ;

   if(onRegisterfeedback != null){
      _alertDialogueBuilder(onRegisterfeedback);
     setState(() {
       hereLoading = false;
     });

   }
   else {Navigator.pop(context);}


 }


  bool hereLoading = false;
  String _registeremail = '';
  String _registerpassword = '';


  late FocusNode _passwordfocusnode;
  late FocusNode _examplenode;

  @override
  void initState() {
    // TODO: implement initState
    _passwordfocusnode = FocusNode();
    _examplenode = FocusNode();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordfocusnode.dispose();
    _examplenode.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
        body: SafeArea(

            child: Container(
              width: double.infinity,
              child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text('Hello User!\nCreate a new account',
                    textAlign: TextAlign.center, style: Constants.boldHeading,),
                ),
              ),
              Column(
                children: [
                  CustomTextInput(hint: 'Email',
                    onChanged: (value) {
                      _registeremail = value;
                    },
                    onSubmitted: (value){
                    _passwordfocusnode.requestFocus();
                    },
                    focusNode: _examplenode,
                    textInputAction: TextInputAction.next,
                    isPasswordField: false,
                  ),
                  CustomTextInput(focusNode: _passwordfocusnode,
                    hint: 'New Password',
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                    _registerpassword = value;
                    },
                    onSubmitted: (value) {
                    _Submitform();
                    },
                    isPasswordField: true,
                  ),
                  CustomBtn(text: 'Create new account', onPressed: () {
                    setState(() {
                      _Submitform();
                    });
                  }, outlineBtn: false, isLoading: hereLoading,),
                ],
              ),
              CustomBtn(text: "Sign-in", onPressed: () {
                Navigator.pop(context);
              }, outlineBtn: true),
          ],
        ),
            ))
    );
  }
}
