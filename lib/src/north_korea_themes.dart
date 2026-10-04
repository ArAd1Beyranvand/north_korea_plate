import 'package:plate_core/plate_core.dart';

import 'north_korea_colors.dart';

/// One theme per livery on the reference sheet. Frames are thin and corners
/// near-square on every reference, so the ratios are shared.
abstract final class KPThemes {
  static const double _border = 0.03;
  static const double _radius = 0.06;

  static const PlateTheme private = PlateTheme.monochrome(
    field: KPColors.amber,
    ink: KPColors.amberInk,
    inactive: KPColors.inactiveOnLight,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  static const PlateTheme government = PlateTheme.monochrome(
    field: KPColors.aluminium,
    ink: KPColors.black,
    inactive: KPColors.inactiveOnLight,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: KPColors.diplomaticBlue,
    ink: KPColors.white,
    inactive: KPColors.inactiveOnDark,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  static const PlateTheme military = PlateTheme.monochrome(
    field: KPColors.militaryBlack,
    ink: KPColors.white,
    inactive: KPColors.inactiveOnDark,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
  );

  /// The only two-colour livery. The engine paints labels in [PlateTheme.ink],
  /// so the star comes out navy rather than crimson.
  static const PlateTheme vip = PlateTheme(
    plateBackground: KPColors.vipField,
    plateBorder: KPColors.crimson,
    ink: KPColors.vipInk,
    dividerColor: KPColors.vipInk,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
    activeColor: KPColors.vipInk,
    inactiveColor: KPColors.inactiveOnLight,
  );
}
