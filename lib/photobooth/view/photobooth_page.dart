import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_compositor/image_compositor.dart';
import 'package:io_photobooth/gallery/gallery.dart';
import 'package:io_photobooth/gallery/view/gallery_page.dart';
import 'package:io_photobooth/photobooth/photobooth.dart';
import 'package:photobooth_ui/photobooth_ui.dart';
import 'package:photos_repository/photos_repository.dart';
import 'package:photos_repository/src/photos_repository.dart';

const _videoConstraints = VideoConstraints(
  facingMode: FacingMode(
    type: CameraType.user,
    constrain: Constrain.ideal,
  ),
  width: VideoSize(ideal: 1920, maximum: 1920),
  height: VideoSize(ideal: 1080, maximum: 1080),
);

class PhotoboothPage extends StatelessWidget {
  const PhotoboothPage({Key? key}) : super(key: key);

  static Route route() {
    return AppPageRoute(builder: (_) => const PhotoboothPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoboothBloc(),
      child: Navigator(
        onGenerateRoute: (_) => AppPageRoute(
          builder: (_) => const PhotoboothView(),
        ),
      ),
    );
  }
}

class PhotoboothView extends StatefulWidget {
  const PhotoboothView({Key? key}) : super(key: key);

  @override
  _PhotoboothViewState createState() => _PhotoboothViewState();
}

class _PhotoboothViewState extends State<PhotoboothView> {
  final _controller = CameraController(
    options: const CameraOptions(
      audio: AudioConstraints(enabled: false),
      video: _videoConstraints,
    ),
  );

  bool get _isCameraAvailable =>
      _controller.value.status == CameraStatus.available;

  Future<void> _play() async {
    if (!_isCameraAvailable) return;
    return _controller.play();
  }

  Future<void> _stop() async {
    if (!_isCameraAvailable) return;
    return _controller.stop();
  }

  @override
  void initState() {
    super.initState();
    _initializeCameraController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCameraController() async {
    await _controller.initialize();
    await _play();
  }

  Future<Uint8List> _composite(
      PhotosRepository pr, PhotoboothState ps, CameraImage p) async {
    final composite = await pr.composite(
      aspectRatio: ps.aspectRatio,
      data: p.data,
      width: p.width,
      height: p.height,
      layers: [
        ...ps.assets.map(
          (l) => CompositeLayer(
            angle: l.angle,
            assetPath: 'assets/${l.asset.path}',
            constraints: Vector2D(l.constraint.width, l.constraint.height),
            position: Vector2D(l.position.dx, l.position.dy),
            size: Vector2D(l.size.width, l.size.height),
          ),
        )
      ],
    );
    return Uint8List.fromList(composite);
  }

  String _getPhotoFileName(String photoName) => '$photoName.png';

  void _onSnapPressed({required double aspectRatio}) async {
    final picture = await _controller.takePicture();
    context
        .read<PhotoboothBloc>()
        .add(PhotoCaptured(aspectRatio: aspectRatio, image: picture));
    await _stop();

    var d = Uint8List(0);

    await (_composite(context.read<PhotosRepository>(),
            context.read<PhotoboothBloc>().state, picture)
        .then((value) => d = value));

    await context.read<PhotosRepository>().sharePhoto(
        fileName: _getPhotoFileName('dinopee'), data: d, shareText: '');

    await Navigator.of(context).pushReplacement(GalleryPage.route());
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final aspectRatio = orientation == Orientation.portrait
        ? PhotoboothAspectRatio.portrait
        : PhotoboothAspectRatio.landscape;
    Future.delayed(const Duration(seconds: 5),
        () => _onSnapPressed(aspectRatio: aspectRatio));
    return Scaffold(
      body: _PhotoboothBackground(
        aspectRatio: aspectRatio,
        child: Camera(
          controller: _controller,
          placeholder: (_) => const SizedBox(),
          preview: (context, preview) => PhotoboothPreview(
            preview: preview,
          ),
          error: (context, error) => PhotoboothError(error: error),
        ),
      ),
    );
  }
}

class _PhotoboothBackground extends StatelessWidget {
  const _PhotoboothBackground({
    Key? key,
    required this.aspectRatio,
    required this.child,
  }) : super(key: key);

  final double aspectRatio;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const PhotoboothBackground(),
        Center(
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Container(
              color: PhotoboothColors.black,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
