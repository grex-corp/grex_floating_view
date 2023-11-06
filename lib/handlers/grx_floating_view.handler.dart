import 'package:flutter/material.dart';

import '../enums/grx_aspect_ratio.enum.dart';
import '../extensions/grx_alignment.extension.dart';
import '../models/grx_alignment_distance.model.dart';
import '../models/grx_floating_view_options.model.dart';

class GrxFloatingViewHandler with ChangeNotifier {
  GrxFloatingViewHandler(this._context, this._options);

  final BuildContext _context;
  final GrxFloatingViewOptions _options;

  OverlayEntry? _overlayEntry;
  bool inFloatingViewMode = false;
  bool showSafeArea = true;

  GrxAspectRatio get aspectRatio => _options.style.aspectRatio;
  Size get size =>
      Size(_options.style.width, _options.style.width / aspectRatio.value);
  BorderRadius get borderRadius => _options.style.borderRadius;

  Duration get animationDuration => _options.style.animationDuration;

  Border? get border => _options.style.border;
  Offset get offset => getOffset(
        _options.position.alignment,
        size: size,
        offset: _options.position.offset,
      );

  bool get overlayActive => _overlayEntry != null;
  bool get startWithFloatingViewOn => _options.startWithFloatingViewOn;
  bool get freeDrag => _options.freeDrag;

  Icon get buttonIcon => _options.floatingButtonOptions.icon;
  Offset get buttonOffset => getOffset(
        _options.floatingButtonOptions.position.alignment,
        size: Size.fromWidth(
          buttonIcon.size ?? const IconThemeData().size ?? 24.0,
        ),
        offset: _options.floatingButtonOptions.position.offset,
      );

  enableFloatingView() {
    inFloatingViewMode = true;
    notifyListeners();
  }

  disableFloatingView() {
    inFloatingViewMode = false;
    notifyListeners();
  }

  setShowSafeArea(bool show) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 100), () {
        showSafeArea = show;
        notifyListeners();
      });
    });
  }

  insertOverlay(OverlayEntry overlay) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    _overlayEntry = null;
    inFloatingViewMode = false;

    Overlay.of(_context).insert(overlay);

    _overlayEntry = overlay;
  }

  removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    _overlayEntry = null;
  }

  Alignment calculateNearestAlignment({
    required Offset offset,
  }) {
    AlignmentDistance calculateDistance(Alignment alignment) {
      final distance = alignment
          .offset(_context, size)
          .translate(
            -offset.dx,
            -offset.dy,
          )
          .distanceSquared;

      return AlignmentDistance(
        alignment: alignment,
        distance: distance,
      );
    }

    final distances =
        GrxAlignmentExtension.values.map(calculateDistance).toList();

    distances.sort((a, b) => a.distance.compareTo(b.distance));

    return distances.first.alignment;
  }

  Offset getOffset(
    final Alignment alignment, {
    final Size? size,
    final Offset? offset,
  }) =>
      alignment.offset(
        _context,
        size ?? this.size,
        offset: offset ?? _options.position.offset,
      );
}
