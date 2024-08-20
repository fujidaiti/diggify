import 'package:flutter/material.dart';

enum ThumbnailShape {
  square(aspectRatio: 1.0),
  circle(aspectRatio: 1.0),
  wide(aspectRatio: 16.0 / 9.0);

  const ThumbnailShape({required this.aspectRatio});

  final double aspectRatio;
}

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    super.key,
    required this.src,
    required this.shape,
  });

  final ImageProvider src;
  final ThumbnailShape shape;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: shape.aspectRatio,
      // child: Image(image: src),
      child: Placeholder(),
    );
  }
}
