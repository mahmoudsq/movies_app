import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, required this.width,
    required this.height, this.function, required this.text,
    this.buttonBackground = Colors.black,this.radius = 25,this.haveIcon = false,
  this.iconData, required this.fontSize, this.iconColor = Colors.white,
    this.textColor = Colors.white}) : super(key: key);
  final double width;
  final double height;
  final double fontSize;
  final VoidCallback? function;
  final String text;
  final Color buttonBackground;
  final double radius;
  final bool haveIcon;
  final IconData? iconData;
  final Color iconColor;
  final Color textColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: buttonBackground,
        borderRadius: BorderRadius.circular(radius),
        //gradient: gradient,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            haveIcon ? Icon(iconData,color: iconColor,) : Container(),
            haveIcon ? SizedBox(width: width * 0.03,): Container(),
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
