import 'package:flutter/material.dart';

import '../services/grx_floating_view.service.dart';

class GrxFloatingViewConsumer extends StatelessWidget {
  const GrxFloatingViewConsumer({
    super.key,
    required this.service,
    required this.builder,
  });

  final GrxFloatingViewService service;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: service.handler,
      builder: (context, _) {
        return builder(
          context,
        );
      },
    );
  }
}
