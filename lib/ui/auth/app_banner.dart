import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 94.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue,
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black26,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: const Text(
        'MilkTea Shop',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontFamily: 'Anton',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
