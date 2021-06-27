import 'package:flutter/material.dart';
import 'package:io_photobooth/footer/footer.dart';
import 'package:io_photobooth/gallery/gallery.dart';
import 'package:photobooth_ui/photobooth_ui.dart';
import 'package:io_photobooth/photobooth/photobooth.dart';
import 'dart:async';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  static Route route() {
    return AppPageRoute(builder: (_) => const GalleryPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PhotoboothColors.white,
      body: GalleryView(),
    );
  }
}

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const delay = const Duration(seconds: 10);
    new Timer.periodic(
        delay,
        (Timer t) =>
            Navigator.of(context).pushReplacement(PhotoboothPage.route()));
    return const AppPageView(
      background: GalleryBackground(),
      body: GalleryBody(),
      footer: BlackFooter(),
    );
  }
}
