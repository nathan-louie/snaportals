part of 'photobooth_bloc.dart';

abstract class PhotoboothEvent extends Equatable {
  const PhotoboothEvent();

  @override
  List<Object> get props => [];
}

class PhotoCaptured extends PhotoboothEvent {
  const PhotoCaptured({required this.aspectRatio, required this.image});

  final double aspectRatio;
  final CameraImage image;

  @override
  List<Object> get props => [aspectRatio, image];
}
