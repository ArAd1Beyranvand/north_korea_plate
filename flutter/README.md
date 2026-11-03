FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of North Korea to view examples:

https://platexample.ir/#/discover/north_korea:flutter

# north_korea_plate

North Korea's licence plates for the plate_core library — the regional private and government series, diplomatic, military and VIP plates.

## Languages

| Language | Folder | Example |
| --- | --- | --- |
| Flutter / Dart | [`flutter/`](https://github.com/ArAd1Beyranvand/north_korea_plate/tree/main/flutter) | [platexample](https://platexample.ir/#/discover/north_korea:flutter) |
| Kotlin | [`kotlin/`](https://github.com/ArAd1Beyranvand/north_korea_plate/tree/main/kotlin) | [platexample](https://platexample.ir/#/discover/north_korea:kotlin) |
| Python | [`python/`](https://github.com/ArAd1Beyranvand/north_korea_plate/tree/main/python) | [platexample](https://platexample.ir/#/discover/north_korea:python) |
| TypeScript | [`typescript/`](https://github.com/ArAd1Beyranvand/north_korea_plate/tree/main/typescript) | [platexample](https://platexample.ir/#/discover/north_korea:typescript) |

## Quick start

### Install

```yaml
dependencies:
  plate_core: ^0.12.0
  north_korea_plate: ^0.1.0
```

### Use

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

## Specs

Each spec is one plate layout.

- `KPPlates.regional` — id `kp.regional`
- `KPPlates.diplomatic` — id `kp.diplomatic`
- `KPPlates.military` — id `kp.military`
- `KPPlates.vip` — id `kp.vip`

## Themes

- `KPThemes.private`
- `KPThemes.government`
- `KPThemes.diplomatic`
- `KPThemes.military`
- `KPThemes.vip`

## Change it

`PlateCanvas` takes `spec:` (an entry of `KPPlates`) and `theme:` (an entry of `KPThemes`). Set `validator:` to `KPValidator()` and `autoValidate: true` to show validation hints.

## Also included

- `KPCountry` — the country panel.
- `KPValidator` — the plate validator.
- `KPRegions` — code table.

## Plates

Not implemented: pre-2004 green plates (still on some cars), the
2004-2006 series, motorcycle, police and construction plates (the article
describes them but gives no picture to measure), and the temporary plate
(`Plak-Movaqqat`, captionless red-struck sheet).

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/north_korea_plate/blob/main/LICENSE).
