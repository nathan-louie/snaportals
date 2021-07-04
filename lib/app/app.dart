import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:io_photobooth/gallery/gallery.dart';
import 'package:photobooth_ui/photobooth_ui.dart';
import 'package:photos_repository/photos_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.photosRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final PhotosRepository photosRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: photosRepository),
      ],
      child: AnimatedFadeIn(
        child: ResponsiveLayoutBuilder(
          small: (_, __) => _App(theme: PhotoboothTheme.small),
          medium: (_, __) => _App(theme: PhotoboothTheme.medium),
          large: (_, __) => _App(theme: PhotoboothTheme.standard),
        ),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key, required this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I/O Photo Booth',
      theme: theme,
      home: const GalleryPage(),
    );
  }
}
