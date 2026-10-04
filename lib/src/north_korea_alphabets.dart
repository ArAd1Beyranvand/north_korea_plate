import 'package:plate_core/plate_core.dart';

/// Every North Korean plate uses Western digits; the only script is Hangul.
abstract final class KPAlphabets {
  static const PlateAlphabet digits = PlateAlphabet.latinDigits;

  /// The two-syllable region abbreviation, one value per slot. The thirteen
  /// controlled regions listed on Wikipedia, then the seven South Korean
  /// provinces the state still issues codes for. 링김 appears on a 1990s
  /// government plate on the reference sheet but in no list, so it is kept as
  /// an observed historical code.
  static const PlateAlphabet regions = PlateAlphabet(
    id: 'kp.region',
    characters: <String>[
      '평양', '라선', '평남', '평북', '자강', '황남', '황북', //
      '강원', '함남', '함북', '량강', '남포', '개성',
      '충남', '충북', '경기', '경남', '경북', '전남', '전북',
      '링김',
    ],
    input: AlphabetInput.chosen,
    isNumeric: false,
  );
}
