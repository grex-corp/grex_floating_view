import 'package:flutter/material.dart';

extension GrxAlignmentExtension on Alignment {
  Offset offset(
    final BuildContext context,
    final Size size, {
    final Offset? offset,
  }) {
    final deviceSize = MediaQuery.sizeOf(context);
    final devicePadding = MediaQuery.paddingOf(context);

    const defaultPadding = 16.0;

    final left = devicePadding.left + defaultPadding + (offset?.dx ?? 0);
    final top = devicePadding.top + defaultPadding + (offset?.dy ?? 0);
    final right = deviceSize.width -
        size.width -
        (devicePadding.right + defaultPadding) -
        (offset?.dx ?? 0);
    final bottom = deviceSize.height -
        size.height -
        (devicePadding.bottom + defaultPadding) -
        (offset?.dy ?? 0);

    final centerWidth = deviceSize.width / 2 - (size.width / 2);
    final centerHeight = deviceSize.height / 2 - (size.height / 2);

    return switch (this) {
      Alignment.topLeft => Offset(left, top),
      Alignment.topCenter => Offset(centerWidth, top),
      Alignment.topRight => Offset(right, top),
      Alignment.centerLeft => Offset(left, deviceSize.height / 2),
      Alignment.center => Offset(centerWidth, centerHeight),
      Alignment.centerRight => Offset(right, deviceSize.height / 2),
      Alignment.bottomLeft => Offset(left, bottom),
      Alignment.bottomCenter => Offset(deviceSize.width / 2, bottom),
      Alignment.bottomRight => Offset(right, bottom),
      _ => Offset(top, left),
    };
  }

  static Iterable<Alignment> get values => [
        Alignment.bottomLeft,
        Alignment.bottomRight,
        Alignment.center,
        Alignment.centerLeft,
        Alignment.centerRight,
        Alignment.topLeft,
        Alignment.topRight,
      ];
}
