import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  //const CustomTextInput({Key key}) : super(key: key);

  final String hint;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  CustomTextInput({required this.hint, required this.onChanged, required this.onSubmitted,  required this.focusNode, required this.textInputAction, required this.isPasswordField});

  @override
  Widget build(BuildContext context) {

    bool _isPasswordField = isPasswordField;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.black38),
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        textInputAction: textInputAction,
        obscureText: _isPasswordField,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),

        ),
        style: Constants.regularDarkText,

      ),
    );
  }
}
