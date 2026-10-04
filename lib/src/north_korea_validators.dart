import 'package:plate_core/plate_core.dart';

/// Advisory, never blocking. Checks completeness, and flags the digit 4 as
/// the leading class digit on regional plates: state-owned class prefixes run
/// 1-7 and skip 4 (tetraphobia), per Wikipedia.
class KPValidator extends GatedPlateValidator {
  const KPValidator({this.gateGroup = 'number'});

  @override
  final String gateGroup;

  static const String reasonIncomplete = 'Every position must be filled.';
  static const String reasonFour = 'Class codes never start with 4.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.values.any((v) => v == null || v.isEmpty)) {
      return const PlateValidation.invalid(reasonIncomplete);
    }
    if (entry.group('class').startsWith('4')) {
      return const PlateValidation.invalid(reasonFour);
    }
    return const PlateValidation.valid();
  }
}
