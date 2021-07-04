import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:photobooth_ui/photobooth_ui.dart';
import 'package:uuid/uuid.dart';

part 'photobooth_event.dart';
part 'photobooth_state.dart';

typedef UuidGetter = String Function();

class PhotoboothBloc extends Bloc<PhotoboothEvent, PhotoboothState> {
  PhotoboothBloc([UuidGetter? uuid])
      : uuid = uuid ?? const Uuid().v4,
        super(const PhotoboothState());

  final UuidGetter uuid;

  @override
  Stream<PhotoboothState> mapEventToState(PhotoboothEvent event) async* {
    if (event is PhotoCaptured) {
      yield state.copyWith(
        aspectRatio: event.aspectRatio,
        image: event.image,
        imageId: uuid(),
        selectedAssetId: emptyAssetId,
      );
    }
  }
}
