import 'package:flutter/material.dart';

import '../utils/color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.verticalPadding = 20,
    this.backgroundColor = PRIMARY_COLOR,
    this.textColor = Colors.white,
    this.horizontalPadding = 50,
    this.fontSize = 20,
  });
  final VoidCallback onPressed;
  final String text;
  final double verticalPadding;
  final Color backgroundColor;
  final Color textColor;
  final double horizontalPadding;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          fontFamily: 'SfProDisplay',
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class PrimaryOutlinedButton extends StatelessWidget {
  const PrimaryOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.horizontalPadding = 50,
    this.verticalPadding = 16,
    this.color = PRIMARY_COLOR,
  });
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: color),
      ),
    );
  }
}

class PostActionButton extends StatelessWidget {
  const PostActionButton({
    super.key,
    required this.assetName,
    required this.text,
    required this.onPressed,
  });

  final String assetName;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              height: 20,
              image: AssetImage(assetName),
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ));
  }
}

class AddCartButton extends StatelessWidget {


  const AddCartButton({
    super.key,
    required this.text,
    required this.horizontalPadding,
    required this.verticalPadding,
    this.color = PRIMARY_COLOR,
    required this.onPressed,
  });


  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10,
            ),

          ),
          minimumSize:  Size(horizontalPadding, verticalPadding), //////// HERE
        ),

        onPressed:
          onPressed,

        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 20,
              image: AssetImage("assets/other/add_cart.png"),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: const TextStyle(
                    color: PRIMARY_LIGHT_COLOR
                ),
              ),
            ),
          ],
        ));
  }

}
