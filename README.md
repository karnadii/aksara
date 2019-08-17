# aksårå

A dart package to transliterate Indonesian local script to latin and vice versa, currently only have javanese script, more transliteration to other script like sunda, bali and so on will be added in the future.

[java](https://en.wikipedia.org/wiki/Java) here is a majority ethnic in Indonesia, not to be confused with [java](https://www.java.com) or [javaScript](https://en.wikipedia.org/wiki/JavaScript)

## Getting Started

Depend on it
```yml
dependencies:
  aksara: any
```

import it
```dart
import 'package:aksara/aksara.dart';
```
use it
```dart
void main() {
  var aksara = AksaraJava();
  print(aksara.latinToJava("aksara jawa",isMurdha: true)); //ꦄꦏ꧀ꦱꦫꦗꦮ
  print(aksara.javaToLatin("ꦲꦏ꧀ꦱꦫꦗꦮ")); // aksarajawa (javanese script don't use space)
}
```

## Credits
Javanese script transliteration is ported from [transliterasijawa](https://github.com/bennylin/transliterasijawa) by @bennylin 