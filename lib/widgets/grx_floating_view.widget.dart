import 'package:flutter/material.dart';

import '../handlers/grx_floating_view.handler.dart';

class GrxFloatingViewWidget extends StatefulWidget {
  const GrxFloatingViewWidget({
    super.key,
    required this.handler,
    required this.child,
    required this.onClear,
  });

  final GrxFloatingViewHandler handler;
  final Widget child;
  final void Function() onClear;

  @override
  createState() => _GrxFloatingViewWidgetState();
}

class _GrxFloatingViewWidgetState extends State<GrxFloatingViewWidget> {
  late final GrxFloatingViewHandler handler = widget.handler;
  late final Size _deviceSize = MediaQuery.sizeOf(context);

  late final double _deviceWidth = _deviceSize.width;
  late final double _deviceHeight = _deviceSize.height;

  late Size _size = Size(_deviceWidth, _deviceHeight);

  bool _isFloatingViewOn = false;

  Offset _offset = Offset.zero;

  _onFloatingViewOn() {
    Future.delayed(const Duration(milliseconds: 100), () {
      handler.setShowSafeArea(false);

      setState(() {
        _isFloatingViewOn = true;
        _size = handler.size;
        _offset = handler.offset;
      });
    });
  }

  _onFloatingViewOff() {
    handler.setShowSafeArea(true);

    Future.microtask(() {
      setState(() {
        _isFloatingViewOn = false;
        _size = Size(_deviceWidth, _deviceHeight);
        _offset = Offset.zero;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: handler,
        builder: (context, _) {
          if (handler.inFloatingViewMode != _isFloatingViewOn) {
            _isFloatingViewOn = handler.inFloatingViewMode;
            if (_isFloatingViewOn) {
              _onFloatingViewOn();
            } else {
              _onFloatingViewOff();
            }
          }

          return Stack(
            children: [
              AnimatedPositioned(
                duration: handler.animationDuration,
                left: _offset.dx,
                top: _offset.dy,
                child: Draggable(
                  feedback: const SizedBox.shrink(),
                  onDragUpdate: _isFloatingViewOn
                      ? (off) {
                          setState(() {
                            _offset =
                                _offset.translate(off.delta.dx, off.delta.dy);
                          });
                        }
                      : null,
                  onDragEnd: _isFloatingViewOn
                      ? (DraggableDetails details) {
                          if (details.velocity.pixelsPerSecond.dx < -1000) {
                            widget.onClear();
                          } else if (!handler.freeDrag) {
                            final alignment = handler.calculateNearestAlignment(
                              offset: _offset,
                            );

                            setState(() {
                              _offset = handler.getOffset(alignment);
                            });
                          }
                        }
                      : null,
                  child: GestureDetector(
                    onTap:
                        _isFloatingViewOn ? handler.disableFloatingView : null,
                    child: AnimatedContainer(
                      width: _size.width,
                      height: _size.height,
                      decoration: BoxDecoration(
                        border: handler.border,
                        borderRadius: handler.borderRadius,
                      ),
                      duration: handler.animationDuration,
                      child: ClipRRect(
                        borderRadius: handler.borderRadius,
                        child: handler.inFloatingViewMode
                            ? IgnorePointer(
                                child: widget.child,
                              )
                            : widget.child,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: handler.buttonOffset.dx,
                top: handler.buttonOffset.dy,
                child: AnimatedOpacity(
                  opacity: !handler.inFloatingViewMode ? 1 : 0,
                  duration: handler.animationDuration,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: handler.buttonIcon,
                      onTap: () {
                        handler.enableFloatingView();
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
