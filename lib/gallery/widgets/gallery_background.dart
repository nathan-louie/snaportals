import 'package:flutter/material.dart';
import 'package:photobooth_ui/photobooth_ui.dart';

class GalleryBackground extends StatelessWidget {
  const GalleryBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('landingPage_background'),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xffED8A00), Color(0xffECB900)],
        ),
      ),
    );
  }
}
