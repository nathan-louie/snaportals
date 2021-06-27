import 'package:flutter/material.dart';

class GalleryDisplay extends StatelessWidget {
  const GalleryDisplay({Key? key}) : super(key: key);

  static const List a = [
    'https://firebasestorage.googleapis.com/v0/b/snaportals.appspot.com/o/uploads%2Fdash.png?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/snaportals.appspot.com/o/uploads%2Fdino.png?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/snaportals.appspot.com/o/uploads%2Fsparky.png?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/snaportals.appspot.com/o/uploads%2Fdinopee.png?alt=media',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 200,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: _buildGridTileList());
  }

  List<Container> _buildGridTileList() => List.generate(
      a.length,
      (i) => Container(
              child: Image.network(
            a[i],
            height: 300,
          )));
}
