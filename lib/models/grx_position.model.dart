import 'package:flutter/widgets.dart';

class GrxPosition {
  const GrxPosition({
    this.alignment = Alignment.bottomRight,
    this.offset = const Offset(0, 0),
  });

  final Alignment alignment;
  final Offset offset;
}
