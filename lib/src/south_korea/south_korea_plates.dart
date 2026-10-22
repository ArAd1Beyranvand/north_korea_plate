import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'south_korea_country.dart';

/// Plate coordinates measured off the flats cut from the article's photos
/// (`.plateref/kr`), each normalised to 520 wide. Canvas heights follow the
/// plate's real aspect:
/// - 335x155 (private, diplomatic, military): 240 (aspect 2.17)
/// - 335x170 (commercial): 264 (aspect 1.97; the caption says 355x155 but
///   the photograph is 1.98, and the picture wins)
/// - US Forces: 260 (aspect 2.0)
/// - neon green is the 520x110 Euro-size plate (aspect 4.7)
/// The Euro-size private plate has no measured photograph; only the neon one
/// stands for that size.
///
/// Glyph size: `PlateSlot.box.height` is the glyph height, ink ~0.55 of it
/// for digits, ~0.61 for Hangul. A fixed run is also limited by pitch: the
/// engine advances ~0.6 * 0.72 * height per digit and `spacing` cannot be
/// negative, so a digit box is no taller than `pitch / 0.432`. That, not the
/// plate height, caps most digit rows (private serial: pitch 53 -> 123, ink
/// ~68 against the reference's 109, ~62%).
///
/// ESTIMATED, not measured: every neon-green coordinate and the US Forces
/// dash/digit split are read off the sheet by eye, because the offline fit of
/// the neon photograph is flagged CHECK and its rows are unusable. The army
/// plate is a greyscale photograph of 500x223, scaled by hand.
abstract final class _Layout {
  static const double width = 520;

  static const double rowsHeight = 240;
  static const double commercialHeight = 264;
  static const double usForcesHeight = 260;
  static const double euroHeight = 110;

  /// Private/military digits row: reference ink y 105.2-214.2 (centre 160).
  static const double digitsTop = 98.5;
  static const double digitsHeight = 123;
  static const double serialLeft = 276.8, serialRight = 489.8;

  /// Class field, 2 digits in the photo (ink x 20.8-113) and up to 3 since
  /// 2019: the box fits three digits at pitch 44.7 about x 75.
  static const double classLeft = 8, classRight = 142, classHeight = 103;
  static const double classTop = 160 - classHeight / 2;

  /// Hangul syllable: ink 65 tall, 83 wide at x 140.8-224.5, bottom on the
  /// digit baseline (214).
  static const double letterLeft = 140.8, letterRight = 224.5;
  static const double letterTop = 128, letterHeight = 107;

  /// Army (greyscale photo, 500x223 scaled by hand): unit digits ink x
  /// 29-140, 육 x 156-216 (half-height, centred y~127), serial x 237-488,
  /// digit ink y 75-183 (centre 129).
  static const double armyCentre = 129;
}

/// A field: one slot, one box, [length] characters of which [minLength] make
/// it complete. A fixed run takes the printed pitch as `spacing`.
PlateSlot _field(
  PlateAlphabet alphabet, {
  required double left,
  required double right,
  required double top,
  required double height,
  int length = 1,
  int? minLength,
}) {
  final double pitch = (right - left) / length;
  return PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, top, right - left, height),
    length: length,
    minLength: minLength,
    spacing: length > 1 && minLength == null ? max(0, pitch - 0.6 * 0.72 * height) : 0,
  );
}

PlatePanel _noPanelBox(double height) =>
    PlatePanel(box: PlateBox(0, 0, 0, height), padding: EdgeInsets.zero);

/// One-line plate: class digits, one Hangul syllable, four digits. Private,
/// military and neon-green share it; they differ in canvas, boxes, the
/// syllable's alphabet and the Euroband.
PlateSpec _oneLine({
  required String id,
  required double height,
  required PlateSlot classSlot,
  required PlateSlot letterSlot,
  required PlateSlot serialSlot,
  double? bandEnd,
}) {
  return PlateSpec(
    id: id,
    country: SouthKoreaCountry.south_korea,
    canvasWidth: _Layout.width,
    canvasHeight: height,
    panel: bandEnd == null
        ? _noPanelBox(height)
        : PlatePanel(
            box: PlateBox(0, 0, bandEnd, height),
            padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
          ),
    noPanel: bandEnd == null,
    background: bandEnd == null
        ? PlateSection.plain
        : PlateSection.columns(<PlatePart>[
            PlatePart(const PlateSection.fill(PlateFill.panel), end: bandEnd),
            const PlatePart(PlateSection.plain),
          ]),
    slots: <PlateSlot>[classSlot, letterSlot, serialSlot],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'class'),
      PlateTextGroup(<int>[1], key: 'letter'),
      PlateTextGroup(<int>[2], key: 'serial'),
    ],
  );
}

/// Two rows: a province and class digits over a syllable and serial.
PlateSpec _commercial() {
  const double top2 = 64, h2 = 180;
  return PlateSpec(
    id: 'kr.commercial',
    country: SouthKoreaCountry.south_korea,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.commercialHeight,
    panel: _noPanelBox(_Layout.commercialHeight),
    noPanel: true,
    slots: <PlateSlot>[
      // Row 1 ink y 16.8-79.5 (centre 48); a taller box would leave the plate.
      _field(SouthKoreaAlphabets.regions, left: 114.8, right: 249.8, top: 0, height: 96),
      _field(SouthKoreaAlphabets.digits, left: 281.2, right: 348.5, top: 0, height: 96, length: 2),
      // Row 2 ink y 98.8-209.2 (centre 154), 가 ink x 29-127.
      _field(SouthKoreaAlphabets.commercialLetters, left: 29.2, right: 126, top: 77.5, height: 172),
      _field(SouthKoreaAlphabets.digits, left: 163.2, right: 465, top: top2, height: h2, length: 4),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'region'),
      PlateTextGroup(<int>[1], key: 'class'),
      PlateTextGroup(<int>[2], key: 'letter'),
      PlateTextGroup(<int>[3], key: 'serial'),
    ],
  );
}

/// 외교 over `123-456`. Row 1 ink y 16.8-83, 외 x 175.5-231, 교 x 268-326;
/// row 2 ink y 115-211 (centre 163), groups x 36.8-209.2 and 297-482, dash
/// x 231-271.5.
PlateSpec _diplomatic() {
  const double top = 163 - 133 / 2, h = 133;
  return PlateSpec(
    id: 'kr.diplomatic',
    country: SouthKoreaCountry.south_korea,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.rowsHeight,
    panel: _noPanelBox(_Layout.rowsHeight),
    noPanel: true,
    slots: <PlateSlot>[
      _field(SouthKoreaAlphabets.digits, left: 36.8, right: 209.2, top: top, height: h, length: 3),
      _field(SouthKoreaAlphabets.digits, left: 297, right: 482, top: top, height: h, length: 3),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: '외교', box: PlateBox(160, 0, 200, 100), glyphHeight: 100),
      PlateLabel(text: '-', box: PlateBox(231, 100, 40.5, 126), glyphHeight: 126),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'class'),
      PlateTextGroup(<int>[1], key: 'serial', prefix: '-'),
    ],
  );
}

/// `1-6047` over `US FORCES IN KOREA`. Row 1 ink y 44.8-161.2, x 78.5-451.8;
/// caption ink y 178-201.5, x 53-465.
PlateSpec _usForces() {
  return PlateSpec(
    id: 'kr.us_forces',
    country: SouthKoreaCountry.south_korea,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.usForcesHeight,
    panel: _noPanelBox(_Layout.usForcesHeight),
    noPanel: true,
    slots: <PlateSlot>[
      _field(SouthKoreaAlphabets.digits, left: 78.5, right: 128, top: 0, height: 206),
      _field(SouthKoreaAlphabets.digits, left: 190, right: 451.8, top: 0, height: 150, length: 4),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: '-', box: PlateBox(128, 20, 62, 110), glyphHeight: 110),
      PlateLabel(text: 'US FORCES IN KOREA', box: PlateBox(53, 168.5, 412, 43), glyphHeight: 43),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'class'),
      PlateTextGroup(<int>[1], key: 'serial', prefix: '-'),
    ],
  );
}

/// Not implemented: pre-2004 green plates (still on some cars), the
/// 2004-2006 series, motorcycle, police and construction plates (the article
/// describes them but gives no picture to measure), and the temporary plate
/// (`Plak-Movaqqat`, captionless red-struck sheet).
abstract final class SouthKoreaPlates {
  /// `12 가 3456` — black on white; class 2-3 digits since 2019.
  static final PlateSpec private = _oneLine(
    id: 'kr.private',
    height: _Layout.rowsHeight,
    classSlot: _field(
      SouthKoreaAlphabets.digits,
      left: _Layout.classLeft,
      right: _Layout.classRight,
      top: _Layout.classTop,
      height: _Layout.classHeight,
      length: 3,
      minLength: 2,
    ),
    letterSlot: _field(
      SouthKoreaAlphabets.privateLetters,
      left: _Layout.letterLeft,
      right: _Layout.letterRight,
      top: _Layout.letterTop,
      height: _Layout.letterHeight,
    ),
    serialSlot: _field(
      SouthKoreaAlphabets.digits,
      left: _Layout.serialLeft,
      right: _Layout.serialRight,
      top: _Layout.digitsTop,
      height: _Layout.digitsHeight,
      length: 4,
    ),
  );

  /// `38 육 4104` — unit number, branch symbol, serial.
  static final PlateSpec military = _oneLine(
    id: 'kr.military',
    height: _Layout.rowsHeight,
    classSlot: _field(
      SouthKoreaAlphabets.digits,
      left: 20,
      right: 150,
      top: _Layout.armyCentre - _Layout.classHeight / 2,
      height: _Layout.classHeight,
      length: 3,
      minLength: 2,
    ),
    letterSlot: _field(
      SouthKoreaAlphabets.militaryBranch,
      left: 156,
      right: 216,
      top: 87,
      height: 79,
    ),
    serialSlot: _field(
      SouthKoreaAlphabets.digits,
      left: 237,
      right: 488,
      top: _Layout.armyCentre - _Layout.digitsHeight / 2,
      height: _Layout.digitsHeight,
      length: 4,
    ),
  );

  /// `177 호 1336` on the 520x110 Euro-size plate with the left Euroband.
  static final PlateSpec neon = _oneLine(
    id: 'kr.neon',
    height: _Layout.euroHeight,
    bandEnd: 62,
    classSlot: _field(
      SouthKoreaAlphabets.digits,
      left: 72,
      right: 213,
      top: 0,
      height: 109,
      length: 3,
    ),
    letterSlot: _field(
      SouthKoreaAlphabets.privateLetters,
      left: 227,
      right: 300,
      top: 20,
      height: 70,
    ),
    serialSlot: _field(
      SouthKoreaAlphabets.digits,
      left: 309,
      right: 498,
      top: 0,
      height: 109,
      length: 4,
    ),
  );

  /// `서울 31` over `가 1234` — black on yellow.
  static final PlateSpec commercial = _commercial();

  /// `외교` over `123-456` — white on blue.
  static final PlateSpec diplomatic = _diplomatic();

  /// `1-6047` over `US FORCES IN KOREA` — black on orange.
  static final PlateSpec usForces = _usForces();

  static final List<PlateSpec> all = <PlateSpec>[
    private,
    commercial,
    military,
    diplomatic,
    usForces,
    neon,
  ];
}
