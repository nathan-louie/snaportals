import 'package:flutter/material.dart';
import 'package:io_photobooth/gallery/gallery.dart';
import 'package:io_photobooth/l10n/l10n.dart';

class GalleryBody extends StatelessWidget {
  const GalleryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 48),
          SelectableText(
            l10n.landingPageHeading,
            key: const Key('landingPage_heading_text'),
            style: theme.textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 3000.0,
            child: GalleryDisplay(),
          )
        ],
      ),
    );
  }
}
