import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: const [
          Expanded(child: Divider(thickness: 3)),
          SizedBox(width: 10),
          Text('هيا بنا',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Expanded(child: Divider(thickness: 3)),
        ],
      ),
    );
  }
}
