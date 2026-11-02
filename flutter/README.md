FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of North Korea to view examples:

https://platexample.ir/#/discover/north_korea

# north_korea_plate

North Korea's licence plates for the plate_core library — the regional private and government series, diplomatic, military and VIP plates.

## Install

```yaml
dependencies:
  plate_core: ^0.12.0
  north_korea_plate: ^0.1.0
```

## Use

```dart
import 'package:plate_core/plate_core.dart';
import 'package:north_korea_plate/north_korea_plate.dart';

PlateCanvas(
  spec: KPPlates.regional,
  theme: KPThemes.private,
  validator: const KPValidator(),
  autoValidate: true,
  onChooseCharacter: noCharacterChooser,
);
```

## Contains

- `KPCountry` — country panel: `northKorea`.
- `SouthKoreaCountry` — country panel: `south_korea`.
- `KPPlates` — 4 plate specs: `regional`, `diplomatic`, `military`, `vip`.
- `SouthKoreaPlates` — 6 plate specs: `private`, `military`, `neon`, `commercial`, `diplomatic`, `usForces`.
- `KPThemes` — 5 themes: `private`, `government`, `diplomatic`, `military`, `vip`.
- `SouthKoreaThemes` — 6 themes: `private`, `military`, `commercial`, `diplomatic`, `usForces`, `neon`.
- `KPValidator` — advisory validator; flags the frame, never blocks a keystroke.
- `SouthKoreaValidator` — advisory validator; flags the frame, never blocks a keystroke.
- `NorthKoreaRegions` — code table.
- 1 bundled asset (`flag_of_south_korea.svg`).

## Plates

Not implemented: pre-2004 green plates (still on some cars), the
2004-2006 series, motorcycle, police and construction plates (the article
describes them but gives no picture to measure), and the temporary plate
(`Plak-Movaqqat`, captionless red-struck sheet).

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

