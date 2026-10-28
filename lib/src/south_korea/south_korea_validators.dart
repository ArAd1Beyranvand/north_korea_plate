import 'package:plate_core/plate_core.dart';

/// Judges the class digits (two or three on a passenger plate since 2019, one
/// to two on others), the Hangul syllable and the serial.
class SouthKoreaValidator extends GatedPlateValidator {
  const SouthKoreaValidator();

  @override
  String get gateGroup => 'serial';

  static const String reasonIncomplete = 'Every field must be filled.';
  static const String reasonClass = 'The class number is out of range.';
  static const String reasonDiplomatic =
      'A diplomatic plate is two groups of three digits.';
  static const String reasonUsForces =
      'A US Forces plate is one digit and four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String id = entry.spec.id;
    final String cls = entry.group('class');
    final String serial = entry.group('serial');
    final String letter = entry.group('letter');

    if (id == 'kr.diplomatic') {
      return isDigitsOfLength(cls, 3) && isDigitsOfLength(serial, 3)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonDiplomatic);
    }
    if (id == 'kr.us_forces') {
      return isDigitsOfLength(cls, 1) && isDigitsOfLength(serial, 4)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonUsForces);
    }

    final bool commercial = id == 'kr.commercial';
    if (letter.isEmpty ||
        !isDigitsOfLength(serial, 4) ||
        (commercial && entry.group('region').isEmpty)) {
      return const PlateValidation.invalid(reasonIncomplete);
    }
    final int digits = cls.length;
    if (!isDigits(cls) ||
        digits < 2 ||
        digits > 3 ||
        (digits == 3 && commercial)) {
      return const PlateValidation.invalid(reasonClass);
    }
    return const PlateValidation.valid();
  }
}
