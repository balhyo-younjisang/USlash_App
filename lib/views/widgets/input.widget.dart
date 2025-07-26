import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObsecure;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const InputWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isObsecure,
    this.backgroundColor,
    this.validator,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  State<StatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObsecure,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        errorText: widget.errorText,
        fillColor: widget.backgroundColor,
        filled: widget.backgroundColor != null ? true : false,
        hintText: widget.labelText,
        hintStyle: TextStyle(color: Color.fromRGBO(189, 189, 189, 1)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Color.fromRGBO(224, 224, 224, 1),
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
