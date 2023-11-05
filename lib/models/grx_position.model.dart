import 'package:flutter/widgets.dart';

class GrxPosition {
  const GrxPosition({
    this.alignment = Alignment.bottomRight,
    this.offset,
  });

  final Alignment alignment;
  final Offset? offset;
}
