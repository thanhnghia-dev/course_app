import 'package:flutter/material.dart';

class LabelWithAsterisk extends StatelessWidget {
  final String label;
  final bool isRequired;
  final double fontSize;

  const LabelWithAsterisk({
    super.key,
    required this.label,
    this.isRequired = false,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isRequired)
            TextSpan(
              text: ' *',
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
