import 'package:flutter/material.dart';

class GalleryDisplay extends StatelessWidget {
  const GalleryDisplay({Key? key}) : super(key: key);
  static const List a = [
    'https://picsum.photos/250?image=9',
    'https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg'
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
