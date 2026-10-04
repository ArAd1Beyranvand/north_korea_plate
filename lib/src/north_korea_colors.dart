import 'package:flutter/widgets.dart';

/// North Korean plate colours, each the modal pixel of a region of the
/// worldlicenseplates.com 9/2013 reference sheet — never an adjective from the
/// article. The references are weathered photographs, so the government field
/// is the aluminium as it is, not as it left the factory.
abstract final class KPColors {
  /// Private field. The article says "yellow"; the pixels are a deep amber.
  static const Color amber = Color(0xFFD47C04);
  static const Color amberInk = Color(0xFF140404);

  /// 1990s government: black stencil on bare aluminium.
  static const Color aluminium = Color(0xFFDCD4CC);
  static const Color black = Color(0xFF040404);

  /// 1990s diplomatic field, sampled over open paint (the overall modal,
  /// 0xFF345474, is pulled dark by shadowed relief).
  static const Color diplomaticBlue = Color(0xFF4C74A4);
  static const Color white = Color(0xFFFCFCFC);

  /// Military field.
  static const Color militaryBlack = Color(0xFF14141C);

  /// VIP: navy ink on a cold white, crimson frame and star.
  static const Color vipField = Color(0xFFE4FCFC);
  static const Color vipInk = Color(0xFF040434);
  static const Color crimson = Color(0xFFCC1C64);

  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x66FFFFFF);
}
