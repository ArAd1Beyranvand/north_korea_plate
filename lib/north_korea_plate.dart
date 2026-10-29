// TODO(py): [D5] one module `plates.countries.north_korea`; assets via importlib.resources.
// TODO(ts): [D5] one subpath export `./countries/north_korea`; tree-shakable.
// TODO(kt): [D5] package `countries.north_korea` in the countries module.
export 'src/north_korea_alphabets.dart';
export 'src/north_korea_colors.dart';
export 'src/north_korea_country.dart';
export 'src/north_korea_plates.dart';
export 'src/north_korea_regions.dart';
export 'src/north_korea_themes.dart';
export 'src/north_korea_validators.dart';

export 'src/south_korea/south_korea_colors.dart';
export 'src/south_korea/south_korea_country.dart';
export 'src/south_korea/south_korea_plates.dart';
export 'src/south_korea/south_korea_themes.dart';
export 'src/south_korea/south_korea_validators.dart';
export 'package:plate_alphabet/plate_alphabet.dart' show SouthKoreaAlphabets;
