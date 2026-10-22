import 'package:plate_core/plate_core.dart';

import 'south_korea_colors.dart';

/// South Korea as a [PlateCountry]. Only the neon-green plate has a country
/// block (the Euroband: flag over `KOR`); every other spec sets `noPanel`.
///
/// Flag: https://commons.wikimedia.org/wiki/File:Flag_of_South_Korea.svg
abstract final class SouthKoreaCountry {
  // ignore: constant_identifier_names
  static const PlateCountry south_korea = PlateCountry(
    code: 'kr',
    captionLines: <String>['KOR'],
    panelColor: SouthKoreaColors.euroband,
    panelTextColor: SouthKoreaColors.white,
    flagAspectRatio: 3 / 2,
    flag: SvgPlateAsset('assets/icons/flag_of_south_korea.svg', package: 'north_korea_plate'),
  );
}
