import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Color textColor ;
  final int bgColor;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onPressed,
    @required this.textColor,
    @required this.bgColor})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: 60,
        width: double.infinity,
        child: RaisedButton(
            highlightColor:Colors.grey.withOpacity(0.5),
          color: Color(bgColor),

          //0xFF7c7c73
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(text,
              style: TextStyle(
                letterSpacing:2 ,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 18,
            ),
          ),

        ),

    );
  }
}
