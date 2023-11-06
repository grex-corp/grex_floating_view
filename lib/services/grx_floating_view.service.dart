import 'package:flutter/material.dart';

import '../handlers/grx_floating_view.handler.dart';
import '../models/grx_floating_view_options.model.dart';
import '../widgets/grx_floating_view.widget.dart';

class GrxFloatingViewService {
  GrxFloatingViewService({
    required final BuildContext context,
    final GrxFloatingViewOptions? options,
  }) : _handler = GrxFloatingViewHandler(
          context,
          options ?? GrxFloatingViewOptions(),
        );

  final GrxFloatingViewHandler _handler;

  Listenable get handler => _handler;

  bool get showSafeArea => _handler.showSafeArea;
  bool get inFloatingViewMode => _handler.inFloatingViewMode;
  bool get overlayActive => _handler.overlayActive;

  void putOverlay({
    required final Widget widget,
  }) {
    _handler.showSafeArea = true;
    _handler.disableFloatingView();

    final overlayEntry = OverlayEntry(
      builder: (context) => GrxFloatingViewWidget(
        handler: _handler,
        onClear: () {
          _handler.removeOverlay();
        },
        child: widget,
      ),
    );

    _handler.insertOverlay(overlayEntry);

    /// TODO: Improve startWithFloatingViewOn feature
    if (_handler.startWithFloatingViewOn) {
      _handler.enableFloatingView();
    }
  }

  void removeOverlay() => _handler.removeOverlay();

  void enableFloatingView() => _handler.enableFloatingView();

  void disableFloatingView() => _handler.disableFloatingView();
}
