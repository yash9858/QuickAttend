import'package:flutter/material.dart';

class OutlineBtn extends StatelessWidget {
  final VoidCallback onPress;
  final text;
  const OutlineBtn({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mh * 0.02),
      child: Container(
        decoration: BoxDecoration(
          border: BoxBorder.lerp(
              Border.all(),
              Border.all(color: Colors.teal),
              BorderSide.strokeAlignOutside
          ),
          borderRadius: BorderRadius.circular(mh * 0.025),
        ),
        child: TextButton(
            onPressed: () => onPress(),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: mh * 0.025,
                ),
              ),
            )
        ),
      ),
    );
  }
}
