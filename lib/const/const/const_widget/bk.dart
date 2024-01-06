import 'package:flutter/material.dart';

import '../../../utrls/theme/theme_helper.dart';
class background extends StatefulWidget {
  final Widget child;
  const background({Key? key, required this.child}) : super(key: key);

  @override
  State<background> createState() => _backgroundState();
}

class _backgroundState extends State<background> {
  @override
  Widget build(BuildContext context) {

      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: ThemeHelper().myBoxDecoration(context, Colors.grey, Colors.black),
        child: widget.child,
      );

  }
}
