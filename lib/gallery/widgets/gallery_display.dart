import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:io_photobooth/users_repository.dart';

class GalleryDisplay extends StatefulWidget {
  const GalleryDisplay({Key? key}) : super(key: key);

  @override
  _GalleryList createState() => _GalleryList();
}

class _GalleryList extends State<GalleryDisplay> {
  _GalleryList();

  List a = [];

  @override
  void initState() {
    UsersRepository.cr.snapshots().listen((event) {
      getNewPhotos();
    });
    getNewPhotos();
    super.initState();
  }

  void getNewPhotos() {
    UsersRepository.getPhotos().then((foo) => {
          setState(() {
            a = foo;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 200,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(
            a.length,
            (i) => Container(
                    child: Image.network(
                  a[i],
                  height: 300,
                ))));
  }
}
