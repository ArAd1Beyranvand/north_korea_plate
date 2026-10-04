import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

/// Every North Korean plate uses Western digits; the only script is Hangul.
abstract final class KPAlphabets {
  static const PlateAlphabet digits = PlateAlphabetDigits.english;
  static const PlateAlphabet regions = PlateAlphabetKorea.northRegions;
}
