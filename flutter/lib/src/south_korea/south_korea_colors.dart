import 'package:flutter/widgets.dart';

/// Each colour is the modal pixel of a region of the flats cut from the
/// article's photographs, never an adjective.
abstract final class SouthKoreaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF010101);

  /// Commercial field. The article says "yellow"; the pixels are an amber
  /// yellow.
  static const Color commercial = Color(0xFFFFC913);
  static const Color commercialInk = Color(0xFF010100);

  static const Color diplomatic = Color(0xFF003399);

  static const Color usForces = Color(0xFFFFA200);

  /// The 2024 luxury-car plate: a light lime. Its characters are embossed and
  /// reflective, so the sampled ink is a grey-teal, not black.
  static const Color neon = Color(0xFFB5EC58);
  static const Color neonInk = Color(0xFF6B8D8E);

  /// The anti-forgery Euroband down the neon plate's left edge.
  static const Color euroband = Color(0xFF3088D0);

  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x66FFFFFF);
}
