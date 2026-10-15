import 'package:plate_core/plate_core.dart';

/// Locates a North Korean plate from its two-syllable region prefix.
///
/// Source: the province tables (including the claimed provinces) of
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_North_Korea
abstract final class NorthKoreaRegions {
  static const Map<String, String> _regions = <String, String>{
    '평양': 'Pyongyang City',
    '라선': 'Rason City',
    '평남': 'South Pyongan Province',
    '평북': 'North Pyongan Province',
    '자강': 'Chagang Province',
    '황남': 'South Hwanghae Province',
    '황북': 'North Hwanghae Province',
    '강원': 'Kangwon Province',
    '함남': 'South Hamgyong Province',
    '함북': 'North Hamgyong Province',
    '량강': 'Ryanggang Province',
    '남포': 'Nampo City',
    '개성': 'Kaesong City',
    '충남': "South Ch'ungch'ŏng Province",
    '충북': "North Ch'ungch'ŏng Province",
    '경기': 'Kyŏnggi Province',
    '경남': 'South Kyŏngsang Province',
    '경북': 'North Kyŏngsang Province',
    '전남': 'South Chŏlla Province',
    '전북': 'North Chŏlla Province',
  };

  /// The region of [prefix], or null when empty or not in the article.
  static String? lookup(String prefix) => _regions[prefix];

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));
}
