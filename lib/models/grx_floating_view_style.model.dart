import 'package:flutter/widgets.dart';

import '../constants/defaults.dart';
import '../enums/grx_aspect_ratio.enum.dart';

class GrxFloatingViewStyle {
  GrxFloatingViewStyle({
    this.aspectRatio = GrxAspectRatio.r4x3,
    this.width = Defaults.floatingViewWidth,
    this.border,
    this.animationDuration = const Duration(milliseconds: 200),
    final BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(16.0);

  final GrxAspectRatio aspectRatio;
  final double width;
  final BorderRadius borderRadius;
  final Border? border;
  final Duration animationDuration;
}
