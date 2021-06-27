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
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(a[index]);
        },
        itemCount: a.length);
  }
}
