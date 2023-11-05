import '../enums/grx_aspect_ratio.enum.dart';

extension GrxAspectRatioExtension on GrxAspectRatio {
  double get value => {
        GrxAspectRatio.r3x2: 3 / 2,
        GrxAspectRatio.r4x3: 4 / 3,
        GrxAspectRatio.r5x4: 5 / 4,
        GrxAspectRatio.r9x16: 9 / 16,
        GrxAspectRatio.r16x9: 16 / 9,
        GrxAspectRatio.r16x10: 16 / 10,
        GrxAspectRatio.r21x9: 21 / 9,
      }[this]!;
}
