import 'dart:async';

import 'package:flutter/material.dart';
import 'package:io_photobooth/footer/footer.dart';
import 'package:io_photobooth/gallery/gallery.dart';
import 'package:io_photobooth/photobooth/photobooth.dart';
import 'package:photobooth_ui/photobooth_ui.dart';

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
    Timer.periodic(
        const Duration(seconds: 15),
        (Timer t) =>
            Navigator.of(context).pushReplacement(PhotoboothPage.route()));

    return const AppPageView(
      background: GalleryBackground(),
      body: GalleryBody(),
      footer: Footer(),
    );
  }
}

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

class GalleryBody extends StatelessWidget {
  const GalleryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 48),
          SelectableText(
            'Gallery View',
            key: const Key(''),
            style: theme.textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 900, child: GalleryDisplay()),
        ],
      ),
    );
  }
}
