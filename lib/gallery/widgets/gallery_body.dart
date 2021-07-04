import 'package:flutter/material.dart';
import 'package:io_photobooth/gallery/gallery.dart';

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
