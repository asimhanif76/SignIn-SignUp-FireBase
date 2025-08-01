import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  String hintText;
  Icon icon;
  bool isPasswordField;
  bool readOnly;
  TextEditingController controller;
  FormFieldValidator<String>? validator;

  MyTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      required this.hintText,
      this.isPasswordField = false,
      this.readOnly = false,
      required this.icon});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hintText,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.icon,
      ),
      obscureText: widget.isPasswordField ? _obscureText : false,
      validator: widget.validator,
    );
  }
}
