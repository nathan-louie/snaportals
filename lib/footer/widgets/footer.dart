import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.caption!.copyWith(),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 32),
      ),
    );
  }
}
