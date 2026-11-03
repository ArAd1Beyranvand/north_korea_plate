import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:north_korea_plate/north_korea_plate.dart';

void main() => runApp(
  PlateExampleApp(
    spec: KPPlates.regional,
    theme: KPThemes.private,
    validator: const KPValidator(),
    autoValidate: true,
  ),
);
