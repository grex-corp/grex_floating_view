import 'package:flutter/material.dart';

import 'grx_position.model.dart';

class GrxFloatingButtonOptions {
  const GrxFloatingButtonOptions({
    this.icon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.white,
    ),
    this.position = const GrxPosition(
      alignment: Alignment.topRight,
    ),
  });

  final Icon icon;
  final GrxPosition position;
}
