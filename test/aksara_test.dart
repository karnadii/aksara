import 'package:test/test.dart';

import 'package:aksara/aksara.dart';

void main() {
  test('run translatiration form java to latin and vice versa', () {
    final aksara = AksaraJava();
    expect(aksara.latinToJava("aksarajawa"), "ꦲꦏ꧀ꦱꦫ​ꦗꦮ");
    expect(aksara.javaToLatin("ꦲꦏ꧀ꦱꦫ​ꦗꦮ"), "aksarajawa");
    expect(() => aksara.latinToJava(null), throwsNoSuchMethodError);
    expect(() => aksara.javaToLatin(null), throwsNoSuchMethodError);
  });
}
