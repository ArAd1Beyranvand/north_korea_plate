FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of North Korea to view examples:

https://platexample.ir/#/discover/north_korea:python

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

### Install (Python)

Copy `python/plates/countries/north_korea/` into `plate_core/python/plates/countries/`.

Then run the tests from `plate_core/python/`: `pytest`.

### Use

```python
from plates.countries.north_korea.data import SPECS, THEMES

spec = SPECS["kp.regional"]
theme = THEMES["KPThemes.private"]
print(spec.id)
```

## Specs

The specs are the same in every language (they come from shared data).

- `kp.regional`
- `kp.diplomatic`
- `kp.military`
- `kp.vip`
- `kr.private`
- `kr.military`
- `kr.neon`
- `kr.commercial`
- `kr.diplomatic`
- `kr.us_forces`

## Themes

- `KPThemes.private`
- `KPThemes.government`
- `KPThemes.diplomatic`
- `KPThemes.military`
- `KPThemes.vip`
- `SouthKoreaThemes.private`
- `SouthKoreaThemes.commercial`
- `SouthKoreaThemes.diplomatic`
- `SouthKoreaThemes.usForces`
- `SouthKoreaThemes.neon`

## Change it

- Pick a spec: use another key of `SPECS`.
- Pick a theme: use another key of `THEMES`.
- Validators: `VALIDATORS` maps the names `KPValidator`, `SouthKoreaValidator` to classes.

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/north_korea_plate/blob/main/LICENSE).
