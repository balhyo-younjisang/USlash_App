import 'package:flutter/material.dart';

class ColoredTextButton extends StatelessWidget {
  const ColoredTextButton({
    super.key,
    required this.pressHandler,
    required this.text,
    required this.color,
    required this.backgroundColor,
    this.height,
    this.width,
  });
  final VoidCallback pressHandler;
  final String text;
  final Color color;
  final Color backgroundColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width,
      height: height ?? size.height * 0.06,
      child: ElevatedButton(
        onPressed: pressHandler,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
        ),
        child: Text(text, style: TextStyle(color: color)),
      ),
    );
  }
}
