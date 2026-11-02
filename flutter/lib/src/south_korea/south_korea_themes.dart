import 'package:plate_core/plate_core.dart';

import 'south_korea_colors.dart';

/// One theme per livery. Frames are thin and corners near-square on every
/// reference, so the ratios are shared.
abstract final class SouthKoreaThemes {
  static const double _border = 0.03;
  static const double _radius = 0.06;

  static const PlateTheme private = PlateTheme.monochrome(
    field: SouthKoreaColors.white,
    ink: SouthKoreaColors.black,
    inactive: SouthKoreaColors.inactiveOnLight,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  /// The article gives military plates the standard plate's colours; the only
  /// photograph is greyscale, so the field is not sampled from it.
  static const PlateTheme military = private;

  static const PlateTheme commercial = PlateTheme.monochrome(
    field: SouthKoreaColors.commercial,
    ink: SouthKoreaColors.commercialInk,
    inactive: SouthKoreaColors.inactiveOnLight,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: SouthKoreaColors.diplomatic,
    ink: SouthKoreaColors.white,
    inactive: SouthKoreaColors.inactiveOnDark,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  static const PlateTheme usForces = PlateTheme.monochrome(
    field: SouthKoreaColors.usForces,
    ink: SouthKoreaColors.black,
    inactive: SouthKoreaColors.inactiveOnLight,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  static const PlateTheme neon = PlateTheme.monochrome(
    field: SouthKoreaColors.neon,
    ink: SouthKoreaColors.neonInk,
    inactive: SouthKoreaColors.inactiveOnLight,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );
}
