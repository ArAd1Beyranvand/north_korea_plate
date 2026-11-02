"""Port of north_korea_plate/lib/src/north_korea_validators.dart. Hand-ported; codegen never overwrites this file."""
from __future__ import annotations

from dataclasses import dataclass

from plates.core.model.plate_alphabet import AlphabetInput
from plates.core.validators.plate_validator import GatedPlateValidator, PlateEntry, PlateValidation


@dataclass(frozen=True)
class KPValidator(GatedPlateValidator):
    gate_group: str = "number"

    reason_incomplete = "Every position must be filled."
    reason_four = "Class codes never start with 4."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for i, slot in enumerate(entry.spec.slots):
            value = entry.values[i] or ""
            want = 1 if slot.alphabet.input == AlphabetInput.CHOSEN else slot.length
            if not value or (want > 1 and len(value) != want):
                return PlateValidation.invalid(self.reason_incomplete)
        if entry.group("class").startswith("4"):
            return PlateValidation.invalid(self.reason_four)
        return PlateValidation.valid()
