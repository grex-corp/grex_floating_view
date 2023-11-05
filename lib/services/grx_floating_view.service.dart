import 'package:flutter/material.dart';

import '../handlers/grx_floating_view.handler.dart';
import '../models/grx_floating_view_options.model.dart';
import '../widgets/grx_floating_view.widget.dart';

class GrxFloatingViewService {
  GrxFloatingViewService({
    required final BuildContext context,
    final GrxFloatingViewOptions? options,
  }) : handler = GrxFloatingViewHandler(
          context,
          options ?? GrxFloatingViewOptions(),
        );

  final GrxFloatingViewHandler handler;

  bool get showSafeArea => handler.showSafeArea;
  bool get inFloatingViewMode => handler.inFloatingViewMode;
  bool get overlayActive => handler.overlayActive;

  void putOverlay({
    required final Widget widget,
  }) {
    handler.showSafeArea = true;
    handler.disableFloatingView();

    final overlayEntry = OverlayEntry(
      builder: (context) => GrxFloatingViewWidget(
        handler: handler,
        onClear: () {
          handler.removeOverlay();
        },
        child: widget,
      ),
    );

    handler.insertOverlay(overlayEntry);

    /// TODO: Improve startWithFloatingViewOn feature
    if (handler.startWithFloatingViewOn) {
      handler.enableFloatingView();
    }
  }

  void enableFloatingView() => handler.enableFloatingView();

  void disableFloatingView() => handler.disableFloatingView();
}
