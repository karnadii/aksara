import 'package:aksara/aksara.dart';

void main() {
  var aksara = AksaraJava();
  print(aksara.latinToJava("aksara jawa", isMurdha: true)); //ꦄꦏ꧀ꦱꦫꦗꦮ
  print(aksara
      .javaToLatin("ꦲꦏ꧀ꦱꦫꦗꦮ")); // aksarajawa (javanese script don't use space)
}
