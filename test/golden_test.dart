import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:north_korea_plate/north_korea_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category on the reference sheet, rendered with real faces
/// so the Hangul and the digit widths can be measured against it.
/// Regenerate with `flutter test --update-goldens`.
void main() {
  setUpAll(() async {
    final loader = FontLoader('Roboto');
    for (final path in const [
      // One face covering Hangul and digits: the test engine does not fall
      // back across faces in a family, so a Latin face first leaves tofu.
      '/usr/share/fonts/opentype/noto/NotoSansCJK-Bold.ttc',
    ]) {
      final file = File(path);
      if (!file.existsSync()) {
        markTestSkipped('missing font $path');
        continue;
      }
      loader.addFont(file.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  final cases = <(String, PlateSpec, PlateTheme, List<String?>)>[
    ('private', KPPlates.regional, KPThemes.private, ['평남', '68', '366']),
    ('government', KPPlates.regional, KPThemes.government, ['함북', '33', '968']),
    ('diplomatic', KPPlates.diplomatic, KPThemes.diplomatic, ['07', '01']),
    ('military', KPPlates.military, KPThemes.military, ['865607']),
    ('vip', KPPlates.vip, KPThemes.vip, ['360']),
  ];

  for (final (name, spec, theme, values) in cases) {
    testWidgets(name, (tester) async {
      expect(debugValidateSpec(spec), isTrue);
      final controller = PlateController.fromValues(spec, values);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 520,
                height: 520 * spec.canvasHeight / spec.canvasWidth,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: KPCountry.northKorea,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(find.byType(PlateView), matchesGoldenFile('goldens/kp_$name.png'));
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }

  test('validator flags a class code starting with 4', () {
    const v = KPValidator();
    final ok = v.judge(PlateEntry(spec: KPPlates.regional, values: ['평양', '15', '421']));
    final four = v.judge(PlateEntry(spec: KPPlates.regional, values: ['평양', '45', '421']));
    expect(ok.reason, isNull);
    expect(four.reason, KPValidator.reasonFour);
  });
}
