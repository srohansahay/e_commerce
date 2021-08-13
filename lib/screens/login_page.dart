import 'package:e_commerce/screens/register_page.dart';
import 'package:e_commerce/widgets/customBtn.dart';
import 'package:e_commerce/widgets/custom_inputText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  //const LoadingPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  bool hereLoading = false;
  String _signinemail = '';
  String _signinpassword = '';


  late FocusNode _examplenode;
  late FocusNode _passwordfocusnode;

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context, barrierDismissible: false, builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        title: Text('Oops!'),
        content: Container(child: Text(error),),
        actions: [TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('Back'))],
      );
    });
  }

  Future<String?> _siginwithEmailandPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _signinemail, password: _signinpassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return 'Credentials entered are wrong :(';
    }catch (e) {
      return 'Credentials entered are wrong :(';
    }
  }

  void _SubmitForm() async {

    setState(() {
      hereLoading = true;
    });

    String? _onSigninfeedback = await _siginwithEmailandPassword();
    if(_onSigninfeedback != null){
      _alertDialogBuilder(_onSigninfeedback);
      setState(() {
        hereLoading = false;
      });
    }
  }

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
          body: SafeArea(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text('Welcome User!\nLogin to your account',
                    textAlign: TextAlign.center, style: Constants.boldHeading,),
                ),
              ),
              Column(
                children: [
                  CustomTextInput(hint: 'Email',
                    onSubmitted: (value) {
                      _passwordfocusnode.requestFocus();
                    },
                    onChanged: (value) {
                      _signinemail = value;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _examplenode,
                    isPasswordField: false,
                  ),
                  CustomTextInput(hint: 'Password',
                    onSubmitted: (value) {
                      _SubmitForm();
                    },
                    onChanged: (value) {
                      _signinpassword = value;
                    },
                    textInputAction: TextInputAction.done,
                    isPasswordField: true,
                    focusNode: _passwordfocusnode,),
                  CustomBtn(text: 'Sign-in', onPressed: () {
                    setState(() {
                      _SubmitForm();

                    });
                  }, outlineBtn: false, isLoading: hereLoading,),
                ],
              ),
              CustomBtn(text: "Create new account", onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              }, outlineBtn: true),
            ],
          ))
      );
    }
  }

