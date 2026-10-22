import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'north_korea_alphabets.dart';
import 'north_korea_country.dart';
import 'north_korea_regions.dart';

/// Coordinates measured off the eight plates of the worldlicenseplates.com
/// 9/2013 sheet, normalised to 440x140. No physical size is documented, so the
/// canvas is the median measured aspect ratio (3.16, range 2.88-3.86).
abstract final class _Layout {
  static const double width = 440;
  static const double height = 140;

  /// The digit box. Reference ink is ~100; a 120 box paints ~66 (the 0.72
  /// font ratio times a bold cap). Reaching 100 needs a ~180 box on a 140
  /// plate, and anything above 120 makes neighbouring digits touch at a 52
  /// pitch, so 120 (~66% of reference height) is the ceiling.
  ///
  /// The box sits at the top edge: Noto Sans CJK puts its ink low in the box,
  /// and at top 10 the row measured cy 76 against the reference's ~65.
  static const double digitTop = 0;
  static const double digitHeight = 120;

  static const double cell = 52;

  /// Hyphen/dot run between groups. The reference gap is ~24 wider than a
  /// digit step; the rendered hyphen is ~29 wide at digit size, so it gets a
  /// 30 run and a smaller glyph, lowered onto the digits' centre line (labels
  /// are top-aligned in their box, and at digit top the hyphen sat ~15 high).
  static const double separator = 30;
  static const double separatorGlyph = 90;
  static const double separatorDrop = 22;

  /// Last digit's right edge (reference: 407-425).
  static const double right = 425;

  /// Prefix area: the region pair spans x 40-138 on the references (pair
  /// centre ~88). Starting at 12 put the rendered pair at 72; at 30, ~84.
  static const double prefixLeft = 30;
  static const double prefixRight = 132;

  /// Two Hangul syllables at ~0.72 * glyphHeight each must fit the 120-wide
  /// prefix area, so the pair paints shorter (~50) than the reference (~100),
  /// whose lettering is condensed. A single glyph (외, ㄱ, ★) takes the
  /// digit height.
  static const double regionGlyph = 76;
}

/// [prefixAlphabet] makes the prefix an editable slot (the region); otherwise
/// [prefixLabel] prints it. [leadSeparator] goes between prefix and first
/// group; [separator] between groups. A printed prefix is one glyph whose ink
/// sits differently in its em box from font to font, so it takes its own
/// [prefixGlyph] size and [prefixShift].
PlateSpec _plate({
  required String id,
  PlateAlphabet? prefixAlphabet,
  String? prefixLabel,
  required List<int> groups,
  required List<String> groupKeys,
  String? leadSeparator,
  String separator = '-',
  double prefixGlyph = _Layout.digitHeight,
  Offset prefixShift = Offset.zero,
}) {
  assert((prefixAlphabet == null) != (prefixLabel == null));
  const top = _Layout.digitTop, h = _Layout.digitHeight;

  // Lay groups out from the right edge, leftwards.
  final starts = List<double>.filled(groups.length, 0);
  final seps = <double>[];
  var x = _Layout.right;
  for (var g = groups.length - 1; g >= 0; g--) {
    x -= groups[g] * _Layout.cell;
    starts[g] = x;
    if (g > 0 || leadSeparator != null) {
      x -= _Layout.separator;
      seps.add(x);
    }
  }
  final prefixRight = x < _Layout.prefixRight ? x : _Layout.prefixRight;
  final prefixBox = PlateBox(_Layout.prefixLeft, top, prefixRight - _Layout.prefixLeft, h);

  final slots = <PlateSlot>[
    if (prefixAlphabet != null)
      PlateSlot(
        alphabet: prefixAlphabet,
        box: PlateBox(
          prefixBox.left,
          top + (h - _Layout.regionGlyph) / 2,
          prefixBox.width,
          _Layout.regionGlyph,
        ),
      ),
    for (var g = 0; g < groups.length; g++)
      PlateSlot(
        alphabet: KPAlphabets.digits,
        box: PlateBox(starts[g], top, groups[g] * _Layout.cell, h),
        length: groups[g],
        spacing: max(0, _Layout.cell - 0.6 * 0.72 * h),
      ),
  ];

  final textGroups = <PlateTextGroup>[];
  var i = 0;
  if (prefixAlphabet != null) {
    textGroups.add(PlateTextGroup([i++], key: 'region'));
  }
  for (var g = 0; g < groups.length; g++) {
    textGroups.add(
      PlateTextGroup(
        [i++],
        key: groupKeys[g],
        prefix: g > 0 ? separator : (leadSeparator ?? (prefixLabel ?? '')),
      ),
    );
  }

  return PlateSpec(
    id: id,
    country: KPCountry.northKorea,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height), padding: EdgeInsets.zero),
    slots: slots,
    labels: <PlateLabel>[
      if (prefixLabel != null)
        PlateLabel(
          text: prefixLabel,
          box: PlateBox(
            prefixBox.left + prefixShift.dx,
            top + prefixShift.dy,
            prefixBox.width,
            prefixGlyph,
          ),
          glyphHeight: prefixGlyph,
        ),
      for (final (n, sx) in seps.indexed)
        PlateLabel(
          // seps runs right to left, so the last one is the lead separator.
          text: leadSeparator != null && n == seps.length - 1 ? leadSeparator : separator,
          box: PlateBox(sx, top + _Layout.separatorDrop, _Layout.separator, _Layout.separatorGlyph),
          glyphHeight: _Layout.separatorGlyph,
        ),
    ],
    textGroups: textGroups,
    resolveRegion: NorthKoreaRegions.captionOf,
  );
}

/// Colour lives in `KPThemes`, never on a spec.
abstract final class KPPlates {
  /// Region + 2 digits - 3 digits: private (amber) and government
  /// (aluminium) plates share it.
  static final PlateSpec regional = _plate(
    id: 'kp.regional',
    prefixAlphabet: KPAlphabets.regions,
    groups: const [2, 3],
    groupKeys: const ['class', 'number'],
  );

  /// 외 - 2 digits (mission) - 2 digits.
  static final PlateSpec diplomatic = _plate(
    id: 'kp.diplomatic',
    prefixLabel: '외',
    // At digit top 외 measured cy ~52 against the digits' 66.
    prefixShift: const Offset(0, 12),
    leadSeparator: '-',
    groups: const [2, 2],
    groupKeys: const ['mission', 'number'],
  );

  /// ㄱ · 6 digits.
  static final PlateSpec military = _plate(
    id: 'kp.military',
    prefixLabel: 'ㄱ',
    // Fonts draw the compatibility jamo small and high: its ink spans
    // 0.28-0.67 of the glyph height and is ~0.43 of it wide. The reference ㄱ
    // is ink ~99 tall centred x~46, but wider than ~55 it covers the dot, so
    // 128 (ink ~50), shifted until its centre measured on the digit line.
    prefixGlyph: 128,
    prefixShift: const Offset(-10, 18),
    leadSeparator: '·',
    groups: const [6],
    groupKeys: const ['serial'],
  );

  /// ★ - 3 digits, no region.
  static final PlateSpec vip = _plate(
    id: 'kp.vip',
    prefixLabel: '★',
    // At digit top the star measured cy 48 against the reference's 69.
    prefixShift: const Offset(0, 20),
    leadSeparator: '-',
    groups: const [3],
    groupKeys: const ['serial'],
  );

  static final List<PlateSpec> all = <PlateSpec>[regional, diplomatic, military, vip];
}
