import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:north_korea_plate/north_korea_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`platekit golden-check`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      // One face covering Hangul and digits, as the North Korean goldens use:
      // the test engine does not fall back across faces in a family.
      '/usr/share/fonts/opentype/noto/NotoSansCJK-Bold.ttc',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  /// category id -> (spec, theme, sample value: one space-separated token
  /// per slot, i.e. per field — `'AB 1234'`, never `'A B 1 2 3 4'`)
  final Map<String, (PlateSpec, PlateTheme, String)> cases =
      <String, (PlateSpec, PlateTheme, String)>{
        'private': (SouthKoreaPlates.private, SouthKoreaThemes.private, '12 가 3456'),
        'commercial': (SouthKoreaPlates.commercial, SouthKoreaThemes.commercial, '서울 31 가 1234'),
        'military': (SouthKoreaPlates.military, SouthKoreaThemes.military, '38 육 4104'),
        'diplomatic': (SouthKoreaPlates.diplomatic, SouthKoreaThemes.diplomatic, '123 456'),
        'us_forces': (SouthKoreaPlates.usForces, SouthKoreaThemes.usForces, '1 6047'),
        'neon': (SouthKoreaPlates.neon, SouthKoreaThemes.neon, '177 호 1336'),
      };

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(spec, values.split(' '));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: SouthKoreaCountry.south_korea,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(find.byType(PlateView), matchesGoldenFile('goldens/kr_${c.key}.png'));
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
