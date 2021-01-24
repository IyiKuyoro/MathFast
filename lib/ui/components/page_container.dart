import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  PageContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
