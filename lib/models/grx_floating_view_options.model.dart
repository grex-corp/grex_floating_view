import 'grx_floating_button_options.model.dart';
import 'grx_floating_view_style.model.dart';
import 'grx_position.model.dart';

class GrxFloatingViewOptions {
  GrxFloatingViewOptions({
    this.position = const GrxPosition(),
    this.floatingButtonOptions = const GrxFloatingButtonOptions(),
    this.startWithFloatingViewOn = false,
    this.freeDrag = false,
    final GrxFloatingViewStyle? style,
  }) : style = style ?? GrxFloatingViewStyle();

  final GrxFloatingViewStyle style;
  final GrxPosition position;
  final GrxFloatingButtonOptions floatingButtonOptions;
  final bool startWithFloatingViewOn;
  final bool freeDrag;
}
