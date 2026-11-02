"""Port of north_korea_plate/lib/src/south_korea/south_korea_validators.dart."""
from __future__ import annotations

from plates.core.validators.plate_validator import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)


class SouthKoreaValidator(GatedPlateValidator):
    gate_group = "serial"

    REASON_INCOMPLETE = "Every field must be filled."
    REASON_CLASS = "The class number is out of range."
    REASON_DIPLOMATIC = "A diplomatic plate is two groups of three digits."
    REASON_US_FORCES = "A US Forces plate is one digit and four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec_id = entry.spec.id
        cls, serial, letter = entry.group("class"), entry.group("serial"), entry.group("letter")
        if spec_id == "kr.diplomatic":
            ok = is_digits_of_length(cls, 3) and is_digits_of_length(serial, 3)
            return PlateValidation.valid() if ok else PlateValidation.invalid(self.REASON_DIPLOMATIC)
        if spec_id == "kr.us_forces":
            ok = is_digits_of_length(cls, 1) and is_digits_of_length(serial, 4)
            return PlateValidation.valid() if ok else PlateValidation.invalid(self.REASON_US_FORCES)
        commercial = spec_id == "kr.commercial"
        if not letter or not is_digits_of_length(serial, 4) or (commercial and not entry.group("region")):
            return PlateValidation.invalid(self.REASON_INCOMPLETE)
        digits = len(cls)
        if not is_digits(cls) or digits < 2 or digits > 3 or (digits == 3 and commercial):
            return PlateValidation.invalid(self.REASON_CLASS)
        return PlateValidation.valid()
