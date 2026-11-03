FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of North Korea to view examples:

https://platexample.ir/#/discover/north_korea:kotlin

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

### Install (Kotlin)

Copy `kotlin/src/commonMain/kotlin/plates/countries/north_korea/` into `plate_core/kotlin/src/commonMain/kotlin/plates/countries/`.

Then run the tests from `plate_core/kotlin/`: `./gradlew jvmTest`.

### Use

```kotlin
import plates.countries.north_korea.country

val spec = country.specs["kp.regional"]
println(country.pkg)
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

- Specs: `country.specs`, by id.
- Themes: `country.themes`.
- Validators: `country.validators` (`KPValidator`, `SouthKoreaValidator`).

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/north_korea_plate/blob/main/LICENSE).
