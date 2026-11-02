import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

/// No plate carries a country block or flag; every spec gives its panel zero
/// width.
abstract final class KPCountry {
  static const Color _transparent = Color(0x00000000);

  static const PlateCountry northKorea = PlateCountry(
    code: 'kp',
    captionLines: <String>[],
    panelColor: _transparent,
    panelTextColor: _transparent,
  );
}
