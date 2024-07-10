import 'package:flutter/material.dart';

class TextBoxBtn extends StatelessWidget {
  final Icon prefix;
  final String label;
  final String hint;
  var validator;
  var controller;
  var keyboard;
  TextBoxBtn({
    super.key,
    required this.prefix,
    required this.label,
    required this.hint,
    this.validator,
    this.controller,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mh = screenSize.height;
    var mw = screenSize.width;
    var isTablet = mw > 600;

    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isTablet ? mw * 0.03 : mh * 0.025),
        ),
        prefixIcon: prefix,
        label: Text(label),
        hintText: hint,
        filled: true,
      ),
      validator: validator,
    );
  }
}


class Btn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const Btn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mh = screenSize.height;
    var mw = screenSize.width;
    var isTablet = mw > 600;

    return SizedBox(
      width: double.infinity,
      height: isTablet ? mh * 0.08 : mh * 0.06,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? mh * 0.05  : mh * 0.023,
          ),
        ),
      ),
    );
  }
}


