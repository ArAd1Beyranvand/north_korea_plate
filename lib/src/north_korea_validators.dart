import 'package:plate_core/plate_core.dart';

/// Checks completeness, and flags 4 as the leading class digit on regional
/// plates: class prefixes run 1-7 and skip 4.
class KPValidator extends GatedPlateValidator {
  const KPValidator({this.gateGroup = 'number'});

  @override
  final String gateGroup;

  static const String reasonIncomplete = 'Every position must be filled.';
  static const String reasonFour = 'Class codes never start with 4.';

  @override
  PlateValidation judge(PlateEntry entry) {
    for (var i = 0; i < entry.spec.slots.length; i++) {
      final slot = entry.spec.slots[i];
      final value = entry.values[i] ?? '';
      // A chosen value (the region) is one symbol, however many characters.
      final want = slot.alphabet.input == AlphabetInput.chosen ? 1 : slot.length;
      if (value.isEmpty || (want > 1 && value.length != want)) {
        return const PlateValidation.invalid(reasonIncomplete);
      }
    }
    if (entry.group('class').startsWith('4')) {
      return const PlateValidation.invalid(reasonFour);
    }
    return const PlateValidation.valid();
  }
}
