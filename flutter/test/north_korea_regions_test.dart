import 'package:flutter_test/flutter_test.dart';
import 'package:north_korea_plate/north_korea_plate.dart';

void main() {
  test('region prefixes resolve', () {
    expect(NorthKoreaRegions.lookup('평양'), 'Pyongyang City');
    expect(NorthKoreaRegions.lookup('함북'), 'North Hamgyong Province');
  });

  test('empty and unlisted prefixes are null', () {
    expect(NorthKoreaRegions.lookup(''), isNull);
    expect(NorthKoreaRegions.lookup('링김'), isNull);
    expect(NorthKoreaRegions.captionOf((_) => ''), isNull);
  });
}
