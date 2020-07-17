import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPress;
  final String btnText;
  final Color backColor;
  final Color textColor;

  const CustomButton(
      {this.onPress, this.btnText, this.backColor, this.textColor});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: backColor,
      onPressed: onPress,
      child: Text(
        btnText,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
