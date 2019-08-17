library aksara;

/*!
* trans.js
* https://bennylin.github.com/transliterasijawa
*
* Copyright 2013, Bennylin @bennylin
* Dual licensed under the MIT or GPL Version 2 licenses.
* Released under the MIT, BSD, and GPL Licenses.
*
* Versions:
* 7 Mei 2013 - v 1.0
* 25 Juli 2013 - v 1.1
* 8 May 2015 - v 1.2
* 1 Juni 2016 - v 1.3
*
*
* Derived with permission from Hindi Transliteration by Markandey Singh @markandey
* http://www.purplegene.com/static/HindiTranslitration.html
*/

/*!
* transliterator.js (Jawa-Latin / Javanese Script to Latin)
* https://bennylin.github.com/transliterasijawa
*
* Copyright 2013, Bennylin @bennylin
* Released under the CC-BY-SA.
*
* Date: 11 April 2013 - v 0.5
* Date: 25 Juli 2013 - v 0.6
*
*
*
*/

/// Class to convert java script to latin and vice versa
class AksaraJava {
  bool _isMurdha = false;
  bool _isCopas = false;
  bool _isSpasi = false;
  bool _vowelPrev = false;

  /// Convert java script to latin
  String javaToLatin(String script) {
    var latinScript = _transliterateJavaToLatin(script);
    return latinScript;
  }

  /// Convert latin to  java script
  ///
  /// jika mode [isCopas] Anda bisa kopipas dari artikel yang menggunakan huruf 'e' beraksen (è/é), misalnya dari artikel Wikipedia bahasa Jawa.
  /// Anda juga bisa menggunakan mode ini untuk mengetik kata-kata dalam bahasa Indonesia, misalnya, karena mayoritas huruf 'e' dalam bahasa Indonesia (terutama imbuhan), adalah pepet
  /// else jika [!isCopas] Dalam mode ini, Anda bisa mengetik secara normal. Tombol 'e' digunakan untuk menuliskan taling, sementara tombol 'x' digunakan untuk menuliskan pepet
  ///
  /// [isMurdha] Pilih menggunakan mode murdha(aksara murdha) atau tidak
  ///
  /// [!isSpasi] Dalam mode ini, jika tanpa spasi teks akan diperlakukan tanpa ada spasi sama sekali, meskipun Anda menggunakan spasi. Teks tidak dapat dikonvert kembali dengan spasi.
  /// [isSpasi]jika dengan spasi, setiap spasi diubah menjadi karakter khusus sehingga dapat ditransliterasi kembali ke Latin dengan spasi.
  String latinToJava(String script,
      {bool isMurdha = false, bool isCopas = false, bool isSpasi = false}) {
    _isCopas = isCopas;
    _isMurdha = isMurdha;
    _isSpasi = _isSpasi;
    var javaScript = _transliterateLatinToJava(script);
    return javaScript;
  }

  String _ganti(String script, int index, String char) {
    return "${script.substring(0, index)}$char";
  }

  String _ganti2(String script, int index, String char) {
    return script.substring(0, index - 1) + char;
  }

  String _ganti3(String script, int index, String char) {
    return script.substring(0, index - 2) + char;
  }

  Map<String, String> javaLatin = {
    "ꦀ": '', //? -- archaic
    "ꦁ": 'ng', //cecak
    "ꦂ": 'r', //layar
    "ꦃ": 'h', //wignyan
    "ꦄ": 'A', //swara-A
    "ꦅ": 'I', //I-Kawi -- archaic
    "ꦆ": 'I', //I
    "ꦇ": 'Ii', //Ii -- archaic
    "ꦈ": 'U', //U
    "ꦉ": 'rě', //pa cêrêk
    "ꦊ": 'lě', //nga lêlêt
    "ꦋ": 'lěu', //nga lêlêt Raswadi -- archaic
    "ꦌ": 'E', //E
    "ꦍ": 'Ai', //Ai
    "ꦎ": 'O', //O

    "ꦏ": 'ka',
    "ꦐ": 'qa', //Ka Sasak
    "ꦑ": 'kha', //Murda
    "ꦒ": 'ga',
    "ꦓ": 'gha', //Murda
    "ꦔ": 'nga',
    "ꦕ": 'ca',
    "ꦖ": 'cha', //Murda
    "ꦗ": 'ja',
    "ꦘ": 'Nya', //Ja Sasak, Nya Murda
    "ꦙ": 'jha', //Ja Mahaprana
    "ꦚ": 'nya',
    "ꦛ": 'tha', //'ṭa',
    "ꦜ": 'ṭha', //Murda
    "ꦝ": 'dha', //'ḍa',
    "ꦞ": 'ḍha', //Murda
    "ꦟ": 'ṇa', //Murda
    "ꦠ": 'ta',
    "ꦡ": 'tha', //Murda
    "ꦢ": 'da',
    "ꦣ": 'dha', //Murda
    "ꦤ": 'na',
    "ꦥ": 'pa',
    "ꦦ": 'pha', //Murda
    "ꦧ": 'ba',
    "ꦨ": 'bha', //Murda
    "ꦩ": 'ma',
    "ꦪ": 'ya',
    "ꦫ": 'ra',
    "ꦬ": 'Ra', //Ra Agung
    "ꦭ": 'la',
    "ꦮ": 'wa',
    "ꦯ": 'sha', //Murda
    "ꦰ": 'ṣa', //Sa Mahaprana
    "ꦱ": 'sa',
    "ꦲ": 'a', //could also be "a" or any sandhangan swara

    "꦳": '​', //cecak telu -- diganti zero-width joiner (tmp)
    "ꦺꦴ": 'o', //taling tarung
    "ꦴ": 'a',
    "ꦶ": 'i',
    "ꦷ": 'ii',
    "ꦸ": 'u',
    "ꦹ": 'uu',
    "ꦺ": 'e',
    "ꦻ": 'ai',
    "ꦼ": 'ě',
    "ꦽ": 'rě',
    "ꦾ": 'ya',
    "ꦿ": 'ra',

    "꧀": '​', //pangkon -- diganti zero-width joiner (tmp)

    "꧁": '—',
    "꧂": '—',
    "꧃": '–',
    "꧄": '–',
    "꧅": '–',
    "꧆": '',
    "꧇": '​', //titik dua -- diganti zero-width joiner (tmp)
    "꧈": ',',
    "꧉": '.',
    "꧊": 'qqq',
    "꧋": '–',
    "꧌": '–',
    "꧍": '–',
    "ꧏ": '²',
    "꧐": '0',
    "꧑": '1',
    "꧒": '2',
    "꧓": '3',
    "꧔": '4',
    "꧕": '5',
    "꧖": '6',
    "꧗": '7',
    "꧘": '8',
    "꧙": '9',
    "꧞": '—',
    "꧟": '—',
    "​": '#', //zero-width joiner
    "​": ' ' //zero-width space
  };

  String _transliterateJavaToLatin(String script) {
    String trans = "";
    for (var i = 0, j = 0; i < script.length; i++) {
      if (javaLatin[script[i]] != null && javaLatin["ꦂ"] == "r") {
        //jawa->latin
        if (script[i] == "ꦲ") {
          //ha
          if (i > 0 &&
              (script[i - 1] == "ꦼ" ||
                  script[i - 1] == "ꦺ" ||
                  script[i - 1] == "ꦶ" ||
                  script[i - 1] == "ꦴ" ||
                  script[i - 1] == "ꦸ" ||
                  script[i - 1] == "ꦄ" ||
                  script[i - 1] == "ꦌ" ||
                  script[i - 1] == "ꦆ" ||
                  script[i - 1] == "ꦎ" ||
                  script[i - 1] == "ꦈ")) {
            trans = _ganti(trans, j, "h" + javaLatin[script[i]]);
            j += 2;
          }
          if (i > 0 && (script[i - 1] == "꧊")) {
            trans = _ganti(trans, j, "H" + javaLatin[script[i]]);
            j += 2;
          } else {
            trans = _ganti(trans, j, javaLatin[script[i]]);
            j++;
          }
        } else if (i > 0 && script[i] == "ꦫ" && script[i - 1] == "ꦂ") {
          //double rr
          trans = _ganti(trans, j, "a");
          j++;
        } else if (i > 0 && script[i] == "ꦔ" && script[i - 1] == "ꦁ") {
          //double ngng
          trans = _ganti(trans, j, "a");
          j++;
        } else if (script[i] == "ꦴ" ||
            script[i] == "ꦶ" ||
            script[i] == "ꦸ" ||
            script[i] == "ꦺ" ||
            script[i] == "ꦼ") {
          if (i > 2 && script[i - 1] == "ꦲ" && script[i - 2] == "ꦲ") {
            //-hah-
            if (script[i] == "ꦴ")
              trans = _ganti3(trans, j, "ā");
            else if (script[i] == "ꦶ")
              trans = _ganti3(trans, j, "ai");
            else if (script[i] == "ꦸ")
              trans = _ganti3(trans, j, "au");
            else if (script[i] == "ꦺ")
              trans = _ganti3(trans, j, "ae");
            else if (script[i] == "ꦼ") trans = _ganti3(trans, j, "aě");
            //script[i] == "ꦶ" || script[i] == "ꦸ" || script[i] == "ꦺ" || script[i] == "ꦼ"
          } else if (i > 2 && script[i - 1] == "ꦲ") {
            //-h-
            if (script[i] == "ꦴ")
              trans = _ganti3(trans, j, "ā");
            else if (script[i] == "ꦶ")
              trans = _ganti3(trans, j, "i");
            else if (script[i] == "ꦸ")
              trans = _ganti3(trans, j, "u");
            else if (script[i] == "ꦺ")
              trans = _ganti3(trans, j, "e");
            else if (script[i] == "ꦼ") trans = _ganti3(trans, j, "ě");
            j--;
            //script[i] == "ꦶ" || script[i] == "ꦸ" || script[i] == "ꦺ" || script[i] == "ꦼ"
          } else if (i > 0 &&
              script[i] == "ꦴ" &&
              script[i - 1] == "ꦺ") //-o //2 aksara -> 1 huruf
          {
            trans = _ganti2(trans, j, "o");
          } else if (i > 0 &&
              script[i] == "ꦴ" &&
              script[i - 1] == "ꦻ") //-au //2 aksara -> 2 huruf
          {
            trans = _ganti3(trans, j, "au");
          } else if (script[i] == "ꦴ") //-aa
          {
            trans = _ganti(trans, j, "aa");
            j++;
          } else if (i > 0 &&
              (script[i] == "ꦶ" ||
                  script[i] == "ꦸ" ||
                  script[i] == "ꦺ" ||
                  script[i] == "ꦼ") &&
              (script[i - 1] == "ꦄ" ||
                  script[i - 1] == "ꦌ" ||
                  script[i - 1] == "ꦆ" ||
                  script[i - 1] == "ꦎ" ||
                  script[i - 1] == "ꦈ")) {
            trans = _ganti(trans, j, javaLatin[script[i]]);
            j++;
          } else {
            trans = _ganti2(trans, j, javaLatin[script[i]]);
          }
        } else if (script[i] == "ꦽ" ||
            script[i] == "ꦾ" ||
            script[i] == "ꦿ" ||
            script[i] == "ꦷ" ||
            script[i] == "ꦹ" ||
            script[i] == "ꦻ" ||
            script[i] == "ꦇ" ||
            script[i] == "ꦍ") {
          //1 aksara -> 2 huruf
          trans = _ganti2(trans, j, javaLatin[script[i]]);
          j++;
        } else if (script[i] == "꦳") {
          //2 aksara -> 2 huruf
          if (i > 0 && script[i - 1] == "ꦗ") {
            if (i > 1 && script[i - 2] == "꧊") {
              trans = _ganti3(trans, j, "Za");
            } else {
              trans = _ganti3(trans, j, "za");
            }
          } else if (i > 0 && script[i - 1] == "ꦥ") {
            if (i > 1 && script[i - 2] == "꧊") {
              trans = _ganti3(trans, j, "Fa");
            } else {
              trans = _ganti3(trans, j, "fa");
            }
          } else if (i > 0 && script[i - 1] == "ꦮ") {
            if (i > 1 && script[i - 2] == "꧊") {
              trans = _ganti3(trans, j, "Va");
            } else {
              trans = _ganti3(trans, j, "va");
            }
          } //catatan, "va" biasanya ditulis sama dengan "fa" (dengan pa+cecak telu), variannya adalah wa+cecak telu.
          else {
            trans = _ganti2(trans, j, javaLatin[script[i]]);
          }
        } else if (script[i] == "꧀") {
          trans = _ganti2(trans, j, javaLatin[script[i]]);
        } else if (i > 1 &&
            script[i] == "ꦕ" &&
            script[i - 1] == "꧀" &&
            script[i - 2] == "ꦚ") {
          //nyj & nyc
          trans = _ganti2(trans, j - 2, "nc");
        } else if (i > 1 &&
            script[i] == "ꦗ" &&
            script[i - 1] == "꧀" &&
            script[i - 2] == "ꦚ") {
          //nyj & nyc
          trans = _ganti2(trans, j - 2, "nj");
        } else if (script[i] == "ꦏ" ||
            script[i] == "ꦐ" ||
            script[i] == "ꦑ" ||
            script[i] == "ꦒ" ||
            script[i] == "ꦓ" ||
            script[i] == "ꦕ" ||
            script[i] == "ꦖ" ||
            script[i] == "ꦗ" ||
            script[i] == "ꦙ" ||
            script[i] == "ꦟ" ||
            script[i] == "ꦠ" ||
            script[i] == "ꦡ" ||
            script[i] == "ꦢ" ||
            script[i] == "ꦣ" ||
            script[i] == "ꦤ" ||
            script[i] == "ꦥ" ||
            script[i] == "ꦦ" ||
            script[i] == "ꦧ" ||
            script[i] == "ꦨ" ||
            script[i] == "ꦩ" ||
            script[i] == "ꦪ" ||
            script[i] == "ꦫ" ||
            script[i] == "ꦬ" ||
            script[i] == "ꦭ" ||
            script[i] == "ꦮ" ||
            script[i] == "ꦯ" ||
            script[i] == "ꦱ" ||
            script[i] == "ꦉ" ||
            script[i] == "ꦊ" ||
            script[i] == "ꦁ") {
          if (i > 0 && script[i - 1] == "꧊") {
            if (script[i] == "ꦐ") {
              trans = _ganti(trans, j, "Qa");
              j += 2;
            } else if (script[i] == "ꦧ" || script[i] == "ꦨ") {
              trans = _ganti(trans, j, "Ba");
              j += 2;
            } else if (script[i] == "ꦕ" || script[i] == "ꦖ") {
              trans = _ganti(trans, j, "Ca");
              j += 2;
            } else if (script[i] == "ꦢ" || script[i] == "ꦣ") {
              trans = _ganti(trans, j, "Da");
              j += 2;
            } else if (script[i] == "ꦒ" || script[i] == "ꦓ") {
              trans = _ganti(trans, j, "Ga");
              j += 2;
            } else if (script[i] == "ꦗ" || script[i] == "ꦙ") {
              trans = _ganti(trans, j, "Ja");
              j += 2;
            } else if (script[i] == "ꦏ" || script[i] == "ꦑ") {
              trans = _ganti(trans, j, "Ka");
              j += 2;
            } else if (script[i] == "ꦭ") {
              trans = _ganti(trans, j, "La");
              j += 2;
            } else if (script[i] == "ꦩ") {
              trans = _ganti(trans, j, "Ma");
              j += 2;
            } else if (script[i] == "ꦤ" || script[i] == "ꦟ") {
              trans = _ganti(trans, j, "Na");
              j += 2;
            } else if (script[i] == "ꦥ" || script[i] == "ꦦ") {
              trans = _ganti(trans, j, "Pa");
              j += 2;
            } else if (script[i] == "ꦫ" || script[i] == "ꦬ") {
              trans = _ganti(trans, j, "Ra");
              j += 2;
            } else if (script[i] == "ꦱ" || script[i] == "ꦯ") {
              trans = _ganti(trans, j, "Sa");
              j += 2;
            } else if (script[i] == "ꦠ" || script[i] == "ꦡ") {
              trans = _ganti(trans, j, "Ta");
              j += 2;
            } else if (script[i] == "ꦮ") {
              trans = _ganti(trans, j, "Wa");
              j += 2;
            } else if (script[i] == "ꦪ") {
              trans = _ganti(trans, j, "Ya");
              j += 2;
            } else {
              _ganti(trans, j, javaLatin[script[i]]);
              j += 3;
            }
          } else if (script[i] == "ꦑ" ||
              script[i] == "ꦓ" ||
              script[i] == "ꦖ" ||
              script[i] == "ꦙ" ||
              script[i] == "ꦡ" ||
              script[i] == "ꦣ" ||
              script[i] == "ꦦ" ||
              script[i] == "ꦨ" ||
              script[i] == "ꦯ") {
            //bha, cha, dha, dll.
            trans = _ganti(trans, j, javaLatin[script[i]]);
            j += 3;
          } else {
            //ba, ca, da, dll.
            trans = _ganti(trans, j, javaLatin[script[i]]);
            j += 2;
          }
        } else if (script[i] == "ꦰ") {
          //ṣa
          trans = _ganti(trans, j, javaLatin[script[i]]);
          j += 2;
        } else if (script[i] == "ꦔ" ||
            script[i] == "ꦘ" ||
            script[i] == "ꦚ" ||
            script[i] == "ꦛ" ||
            script[i] == "ꦜ" ||
            script[i] == "ꦝ" ||
            script[i] == "ꦞ" ||
            script[i] == "ꦋ") {
          if (i > 0 && script[i - 1] == "꧊") {
            if (script[i] == "ꦔ") {
              trans = _ganti(trans, j, "Nga");
              j += 3;
            } else if (script[i] == "ꦚ" || script[i] == "ꦘ") {
              trans = _ganti(trans, j, "Nya");
              j += 3;
            } else if (script[i] == "ꦛ" || script[i] == "ꦜ") {
              trans = _ganti(trans, j, "Tha");
              j += 3;
            } else if (script[i] == "ꦝ" || script[i] == "ꦞ") {
              trans = _ganti(trans, j, "Dha");
              j += 3;
            } else {
              _ganti(trans, j, javaLatin[script[i]]);
              j += 3;
            }
          } else {
            trans = _ganti(trans, j, javaLatin[script[i]]);
            j += 3;
          }
          /*} else if (script[i] == "꧈" || script[i] == "꧉") { // habis titik atau koma diberi spasi
          trans = ganti(trans,j, javaLatin[script[i]]+" ");j+=2;*/
        } else if (script[i] == "꧊") {
          //penanda nama diri -- made up for Latin back-compat
          trans = _ganti(trans, j, "");
        } else if (script[i] == " ") {
          trans = _ganti(trans, j, " ");
          j++;
        } else {
          trans = _ganti(trans, j, javaLatin[script[i]]);
          j++;
        }
      } else if (javaLatin[script[i]] != null && javaLatin["r"] == "ꦂ") {
        //latin->jawa
        if (script[i] == "a" && i > 0) {
          trans = _ganti(trans, j, " ");
          j++;
        } else {
          trans = _ganti(trans, j, javaLatin[script[i]]);
          j++;
        }
      } else {
        trans = _ganti(trans, j, script[i]);

        j++;
      }
    }
    return trans;
  }

  /// SuperTrim, findstr
  /// trim string, menemukan karakter di dalam string
  String _superTrim(String str) {
    str = str == null ? '' : str;
    var ret = str
        .replaceAll(RegExp(r"\s*|\s*$/g"), '')
        .replaceAll(RegExp(r"\s+/g"), ' ');
    return ret;
  }

  bool _findstr(String str, String tofind) {
    for (var i = 0; i < str.length; i++) if (str[i] == tofind) return true;
    return false;
  }

  /// isDigit, isPunct, isVowel
  /// cek apakah digit, tanda baca, atau huruf vokal (a, e/è/é, i, o, u, ě/ê, ô, ā/ī/ū/ō)

  bool _isDigit(String a) {
    var str = "0123456789";
    return _findstr(str, a);
  }

  bool _isPunct(String a) {
    var str = ",.><?/+=-_}{[]*&^%\$#@!~`\"\\|:;()";
    return _findstr(str, a);
  }

  bool _isVowel(String a) {
    var str = "AaEeÈèÉéIiOoUuÊêĚěĔĕṚṛXxôâāīūō";
    return _findstr(str, a);
  }

  bool _isConsonant(String a) {
    var str =
        "BCDfGHJKLMNPRSTVWYZbcdfghjklmnpqrstvwxyzḌḍṆṇṢṣṬṭŊŋÑñɲ"; //QXqx are special chars, add engma & enye
    return _findstr(str, a);
  }

  /// isSpecial, isHR, isLW
  /// cek apakah karakter spesial (bikonsonan/cakra-pengkal/layar-cecak-wignyan/panjingan)

  bool _isSpecial(String a) {
    var str =
        "GgHhRrYyñ"; //untuk bikonsonan th, dh, ng (nga dan cecak), ny, -r- (cakra), -y- (pengkal), jñ (ꦘ)
    return _findstr(str, a);
  }

  bool _isHR(String a) {
    var str =
        "HhRrŊŋ"; //untuk layar dan wignyan //1.3 dan cecak ([[:en:w:Engma]])
    return _findstr(str, a);
  }

  bool _isLW(String a) {
    var str =
        "LlWw"; //untuk panjingan ("ng" dapat diikuti "g", "r"/cakra, "y"/pengkal, dan "w" atau "l"/panjingan)
    return _findstr(str, a);
  }

  bool _isCJ(String a) {
    var str = "CcJj"; //untuk anuswara -nj- dan -nc-
    return _findstr(str, a);
  }

  /// getMatra
  /// apabila huruf vokal, return matra (sandhangan swara)
  String _getMatra(String str) {
    var i = 0;
    if (str.length < 1) {
      return "꧀";
    }
    while (str[i] == 'h') {
      i++;
      if (i >= str.length) {
        break;
      }
    }
    if (i < str.length) {
      str = str.substring(i);
    }
    Map<String, String> matrajavaLatin1 = {
      "ā": "ꦴ",
      "â": "ꦴ",
      "e": 'ꦺ',
      "è": 'ꦺ',
      "é": 'ꦺ',
      "i": 'ꦶ',
      "ī": "ꦷ",
      "o": 'ꦺꦴ',
      "u": 'ꦸ',
      "ū": "ꦹ",
      "x": "ꦼ",
      "ě": "ꦼ",
      "ĕ": "ꦼ",
      "ê": "ꦼ",
      "ō": "ꦼꦴ",
      "ô": "",
      "A": 'ꦄ',
      "E": 'ꦌ',
      "È": 'ꦌ',
      "É": 'ꦌ',
      "I": 'ꦆ',
      "U": 'ꦈ',
      "O": 'ꦎ',
      "X": "ꦄꦼ",
      "Ě": "ꦄꦼ",
      "Ê": "ꦄꦼ",
      "ṛ": "ꦽ",
      "aa": 'ꦴ',
      "ai": 'ꦻ',
      "au": 'ꦻꦴ',
      "ii": 'ꦷ',
      "uu": 'ꦹ'
    };
    Map<String, String> matrajavaLatin2 = {
      "ā": "ꦴ",
      "â": "ꦴ",
      "e": 'ꦼ',
      "è": 'ꦺ',
      "é": 'ꦺ',
      "i": 'ꦶ',
      "ī": "ꦷ",
      "u": 'ꦸ',
      "ū": "ꦹ",
      "o": 'ꦺꦴ',
      "x": "ꦼ",
      "ě": "ꦼ",
      "ĕ": "ꦼ",
      "ê": "ꦼ",
      "ô": "",
      "ō": "ꦼꦴ",
      "A": 'ꦄ',
      "E": 'ꦄꦼ',
      "È": 'ꦌ',
      "É": 'ꦌ',
      "I": 'ꦆ',
      "U": 'ꦈ',
      "O": 'ꦎ',
      "X": "ꦄꦼ",
      "Ě": "ꦄꦼ",
      "Ê": "ꦄꦼ",
      "ṛ": "ꦽ",
      "aa": 'ꦴ',
      "ai": 'ꦻ',
      "au": 'ꦻꦴ',
      "ii": 'ꦷ',
      "uu": 'ꦹ'
    };
    Map<String, String> matrajavaLatin;

    if (_isCopas)
      matrajavaLatin = matrajavaLatin2;
    else //if(mode == "ketik")
      matrajavaLatin = matrajavaLatin1;

    if (matrajavaLatin[str] != null) {
      return matrajavaLatin[str];
    }
    return "";
  }

  /// GetShift
  /// Quick TOC:
  /// 1. ends with 'h' -- th: thr, thl, thw, thy; dh: dhr, dhl, dhw, dhy; hy,hh, rh, kh, gh, ch, jh, ṭh, th: thr, thl; dh: dhr, dhl; hy,hh, rh, kh, gh, ch, jh, ṭh, ḍh, ph, bh, sh, h
  /// 2. ends with 'g' -- ng: ngr, ngy, nggr, nggl, nggw, nggy, ngg, ngng, ngl, njr, ngw; rg, hg, gg, g
  /// 3. ends with 'y' -- ny: nyr, nyl; ry, dhy, thy, y
  /// 4. ends with 'r', panjingan 'l'/'w' -- hr, rr, nggr; ll, rl, hl; rw, hw, ngw
  /// 5. ends with 'c', and 'j' -- nc: ncr, ncl; rc; nj: njr, njl; rj;
  /// 6. ends with 'ñ' -- jñ: jny
  /// apabila huruf bikonsonan, return karakter khusus
  /// TODO: masih case sensitive, mis "RR" masih tidak betul

  CoreSound _getShift(String str) {
    str = str.toLowerCase();
    if (str.indexOf("th") == 0) {
      //suku kata diawali 'th'
      if (str.indexOf("thr") == 0) {
        return CoreSound(coreSound: "ꦛꦿ", len: 3);
      } else if (str.indexOf("thl") == 0) {
        //thl
        return CoreSound(coreSound: "ꦛ꧀ꦭ", len: 3);
      } else if (str.indexOf("thy") == 0) {
        //thy -- ...
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦛꦾ", len: 3);
      } else if (str.indexOf("thw") == 0) {
        //thw -- ...
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦛ꧀ꦮ", len: 3);
      } else {
        return CoreSound(coreSound: "ꦛ", len: 2);
      }
    } else if (str.indexOf("dh") == 0) {
      //suku kata diawali 'dh'
      if (str.indexOf("dhr") == 0) {
        //cakra
        return CoreSound(coreSound: "ꦝꦿ", len: 3);
      } else if (str.indexOf("dhl") == 0) {
        //dhl
        return CoreSound(coreSound: "ꦝ꧀ꦭ", len: 3);
      } else if (str.indexOf("dhy") == 0) {
        //dhy -- dhyaksa
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦝꦾ", len: 3);
      } else if (str.indexOf("dhw") == 0) {
        //dhw -- dhwani
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦝ꧀ꦮ", len: 3);
      } else {
        return CoreSound(coreSound: "ꦝ", len: 2);
      }
    } else if (str.indexOf("hy") == 0) {
      //hyang
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦲꦾ", len: 2);
    } else if (str.indexOf("hh") == 0) {
      //hh
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦃꦲ", len: 2);
    } else if (str.indexOf("rh") == 0) {
      //rh (kata berakhiran r diikuti kata berawalan h
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦂꦲ", len: 2);
    } else if (str.indexOf("kh") == 0) {
      //kh (aksara murda)
      return CoreSound(coreSound: "ꦑ", len: 2);
    } else if (str.indexOf("gh") == 0) {
      //gh (aksara murda)
      return CoreSound(coreSound: "ꦓ", len: 2);
    } else if (str.indexOf("ch") == 0) {
      //ch (aksara murda)
      return CoreSound(coreSound: "ꦖ", len: 2);
    } else if (str.indexOf("jh") == 0) {
      //jh (aksara murda)
      return CoreSound(coreSound: "ꦙ", len: 2);
    } else if (str.indexOf("ṭh") == 0) {
      //ṭh (aksara murda)
      return CoreSound(coreSound: "ꦜ", len: 2);
    } else if (str.indexOf("ḍh") == 0) {
      //ḍh (aksara murda)
      return CoreSound(coreSound: "ꦞ", len: 2);
    } else if (str.indexOf("ph") == 0) {
      //ph (aksara murda)
      return CoreSound(coreSound: "ꦦ", len: 2);
    } else if (str.indexOf("bh") == 0) {
      //bh (aksara murda)
      return CoreSound(coreSound: "ꦨ", len: 2);
    } else if (str.indexOf("sh") == 0) {
      //sh (aksara murda)
      return CoreSound(coreSound: "ꦯ", len: 2);
    } else if (str.indexOf("h") == 1) {
      //h
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "꧀ꦲ", len: 2);
    } else if (str.indexOf("h") > 1) {
      //suku kata memiliki konsonan 'h' yang tidak di awal suku
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound = sound + _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    //nga
    if (str.indexOf("ng") == 0) {
      //suku kata diawali 'ng'
      if (str.indexOf("ngr") == 0) {
        //cakra
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔꦿ", len: 3);
      } else if (str.indexOf("ngy") == 0) {
        //pengkal
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔꦾ", len: 3);
      } else if (str.indexOf("nggr") == 0) {
        //nggronjal
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔ꧀ꦒꦿ", len: 4);
      } else if (str.indexOf("nggl") == 0) {
        //nggl-
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔ꧀ꦒ꧀ꦭ", len: 4);
      } else if (str.indexOf("nggw") == 0) {
        //nggw-, munggwing
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔ꧀ꦒ꧀ꦮ", len: 4);
      } else if (str.indexOf("nggy") == 0) {
        //nggy-, anggyat
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔ꧀ꦒꦾ", len: 4);
      } else if (str.indexOf("ngg") == 0) {
        //ngg
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔ꧀ꦒ", len: 3);
        /*
        } else if (str.indexOf("ngng") == 0) { //ngng
        return { "coreSound": "" + GetcoreSound(str[0]).coreSound + "ꦔ꧀ꦔ", len: 4 };*/
      } else if (str.indexOf("ngl") == 0) {
        //ngl, e.g. ngluwari
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔ꧀ꦭ", len: 3);
      } else if (str.indexOf("ngw") == 0) {
        //ngw, e.g. ngwiru
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦔ꧀ꦮ", len: 3);
      } else {
        return CoreSound(coreSound: "ꦁ", len: 2);
      }
    } else if (str.indexOf("rg") == 0) {
      //'rg', e.g. amarga
      return CoreSound(coreSound: "ꦂꦒ", len: 2);
    } else if (str.indexOf("hg") == 0) {
      //'hg', e.g. dahgene
      return CoreSound(coreSound: "ꦃꦒ", len: 2);
    } else if (str.indexOf("gg") == 0) {
      //'gg', e.g. root word ends with 'g' with suffix starts with vocal
      return CoreSound(coreSound: "ꦒ꧀ꦒ", len: 2);
    } else if (str.indexOf("g") == 1) {
      //g
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "꧀ꦒ", len: 2);
    } else if (str.indexOf("g") > 1) {
      //suku kata memiliki konsonan 'g' yang tidak di awal suku
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound = sound + _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    if (str.indexOf("jñ") == 0) {
      //suku kata diawali 'jñ'
      return CoreSound(coreSound: "ꦘ", len: 2);
    }
    if (str.indexOf("jny") == 0) {
      //suku kata diawali 'jñ'
      return CoreSound(coreSound: "ꦘ", len: 3); // still not working, 22 Jan 19
    }
    //nya
    if (str.indexOf("ny") == 0) {
      //suku kata diawali 'ny'
      if (str.indexOf("nyr") == 0) {
        //cakra
        return CoreSound(coreSound: "ꦚꦿ", len: 3);
      } else if (str.indexOf("nyl") == 0) {
        //nyl, e.g. nylonong
        return CoreSound(coreSound: "ꦚ꧀ꦭ", len: 3);
      } else {
        return CoreSound(coreSound: "ꦚ", len: 2);
      }
    } else if (str.indexOf("ry") == 0) {
      //'ry', e.g. Suryati, Wiryadi
      if (str.indexOf("ryy") == 0) {
        return CoreSound(coreSound: "ꦂꦪꦾ", len: 3);
      } else {
        return CoreSound(coreSound: "ꦂꦪ", len: 2);
      }
    } else if (str.indexOf("yy") == 0) {
      //'yy', e.g. Duryyodhana (Jawa Kuno)
      return CoreSound(coreSound: "ꦪꦾ", len: 2);
    } else if (str.indexOf("qy") == 0) {
      //qy -- only pengkal
      return CoreSound(coreSound: "ꦾ", len: 1);
    } else if (str.indexOf("y") == 1) {
      //pengkal
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦾ", len: 2);
    } else if (str.indexOf("y") > 1) {
      //suku kata memiliki konsonan 'y' yang tidak di awal suku
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound += _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    if (str.indexOf("hr") == 0) {
      //hr-
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦃꦿ", len: 2);
    } else if (str.indexOf("rr") == 0) {
      //rr -- no cakra
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦂꦫ", len: 2);
    } else if (str.indexOf("wr") == 0) {
      //wr -- panjingan + cakra
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦮꦿ", len: 2);
    } else if (str.indexOf("qr") == 0) {
      //qr -- only cakra
      return CoreSound(coreSound: "ꦿ", len: 1);
    } else if (str.indexOf("r") == 1) {
      //cakra
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦿ", len: 2);
    } else if (str.indexOf("r") > 1) {
      //suku kata memiliki konsonan 'r' yang tidak di awal suku
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound += _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    //panjingan -l
    if (str.indexOf("ll") == 0) {
      //ll
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦭ꧀ꦭ", len: 2);
    } else if (str.indexOf("rl") == 0) {
      //rl (kata berakhiran r diikuti kata berawalan l
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦂꦭ", len: 2);
    } else if (str.indexOf("hl") == 0) {
      //hl
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦃꦭ", len: 2);
    } else if (str.indexOf("ql") == 0) {
      //only panjingan
      return CoreSound(coreSound: "꧀ꦭ", len: 2);
    } else if (str.indexOf("l") == 1) {
      //l
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "꧀ꦭ", len: 2);
    } else if (str.indexOf("l") > 1) {
      //suku kata memiliki konsonan 'l' yang tidak di awal suku//panjingan
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound = sound + _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    //panjingan -w
    if (str.indexOf("rw") == 0) {
      //rw
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦂꦮ",
          len: 2); //error untuk 'rwi', 'rwab'
    } else if (str.indexOf("hw") == 0) {
      //hw
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦃꦮ", len: 2); //ꦲ꧀ꦮ
    } else if (str.indexOf("qw") == 0) {
      //only panjingan
      return CoreSound(coreSound: "꧀ꦮ", len: 2);
    } else if (str.indexOf("w") == 1) {
      //w
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "꧀ꦮ", len: 2);
    } else if (str.indexOf("w") > 1) {
      //suku kata memiliki konsonan 'w' yang tidak di awal suku//panjingan
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound = sound + _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    if (str.indexOf("nc") == 0) {
      //nc
      if (str.indexOf("ncr") == 0) {
        //ncr -- kencrung
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦚ꧀ꦕꦿ", len: 3);
      } else if (str.indexOf("ncl") == 0) {
        //ncl -- kinclong
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦚ꧀ꦕ꧀ꦭ", len: 3);
      } else {
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦚ꧀ꦕ", len: 2);
      }
    } else if (str.indexOf("rc") == 0) {
      //rc -- arca
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦂꦕ", len: 2);
    } else if (str.indexOf("c") == 1) {
      //c
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "꧀ꦕ", len: 2);
    } else if (str.indexOf("c") > 1) {
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound = sound + _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    if (str.indexOf("nj") == 0) {
      //nj
      if (str.indexOf("njr") == 0) {
        //njr -- anjrah
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦚ꧀ꦗꦿ", len: 3);
      } else if (str.indexOf("njl") == 0) {
        //njl -- anjlog
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦚ꧀ꦗ꧀ꦭ", len: 3);
      } else {
        return CoreSound(
            coreSound: "" + _getcoreSound(str[0]).coreSound + "ꦚ꧀ꦗ", len: 2);
      }
    } else if (str.indexOf("rj") == 0) {
      //'rj'
      return CoreSound(coreSound: "ꦂꦗ", len: 2);
    } else if (str.indexOf("j") == 1) {
      //j
      return CoreSound(
          coreSound: "" + _getcoreSound(str[0]).coreSound + "꧀ꦗ", len: 2);
    } else if (str.indexOf("j") > 1) {
      var sound = "";
      var len = 0;
      var index = 0;
      for (index = 0; index < str.length; index++) {
        var c = str[index];
        if (!_isVowel(c)) {
          sound = sound + _resolveCharacterSound(c);
          len++;
        } else {
          break;
        }
      }
      return CoreSound(coreSound: sound, len: len);
    }

    return CoreSound(coreSound: null, len: 1);
  }

  /// GetcoreSound, GetSpecialSound
  /// return aksara nglegana maupun aksara istimewa (f/v/z/pangkon)
  CoreSound _getcoreSound(String str) {
    Map<String, String> consonantjavaLatin1 = {
      "A": "ꦄ", //A
      "B": "ꦧ", //B
      "C": "ꦕ", //C
      "D": "ꦢ", //D
      "E": "ꦌ", //E
      "F": "ꦥ꦳", //F
      "G": "ꦒ", //G
      "H": "ꦲ", //H
      "I": "ꦆ", //I
      "J": "ꦗ", //J
      "K": "ꦏ", //K
      "L": "ꦭ", //L
      "M": "ꦩ", //M
      "N": "ꦤ", //N
      "O": "ꦎ", //O
      "P": "ꦥ", //P
      "Q": "꧀", //Q
      "R": "ꦂ", //R
      "S": "ꦱ", //S
      "T": "ꦠ", //T
      "U": "ꦈ", //U
      "V": "ꦮ꦳", //V
      "W": "ꦮ", //W
      "X": "ꦼ", //X
      "Y": "ꦪ", //Y
      "Z": "ꦗ꦳", //Z
      "a": "ꦲ", //a
      "b": "ꦧ", //b
      "c": "ꦕ", //c
      "d": "ꦢ", //d
      "e": "ꦲꦺ", //e
      "f": "ꦥ꦳", //f
      "g": "ꦒ", //g
      "h": "ꦃ", //h
      "i": "ꦲꦶ", //i
      "j": "ꦗ", //j
      "k": "ꦏ", //k
      "l": "ꦭ", //l
      "m": "ꦩ", //m
      "n": "ꦤ", //n
      "o": "ꦲꦺꦴ", //o
      "p": "ꦥ", //p
      "q": "꧀", //q
      "r": "ꦂ", //r
      "s": "ꦱ", //s
      "ś": "ꦯ", //ś
      "t": "ꦠ", //t
      "u": "ꦲꦸ", //u
      "v": "ꦮ꦳", //v
      "w": "ꦮ", //w
      "x": "ꦲꦼ", //x
      "y": "ꦪ", //y
      "z": "ꦗ꦳", //z
      "È": "ꦌ", //È
      "É": "ꦌ", //É
      "Ê": "ꦄꦼ", //Ê
      "Ě": "ꦄꦼ", //Ě
      "è": "ꦲꦺ", //è
      "é": "ꦲꦺ", //é
      "ê": "ꦲꦼ", //ê
      "ě": "ꦲꦼ", //ě
      "ô": "ꦲ", //ô
      "ñ": "ꦚ", //enye
      "ṇ": "ꦟ",
      "ḍ": "ꦝ",
      "ṭ": "ꦛ",
      "ṣ": "ꦰ",
      "ṛ": "ꦽ"
    };
    Map<String, String> consonantjavaLatin2 = {
      "A": "ꦄ", //A
      "B": "ꦨ", //B
      "C": "ꦖ", //C
      "D": "ꦣ", //D
      "E": "ꦌ", //E
      "F": "ꦦ꦳", //F
      "G": "ꦓ", //G
      "H": "ꦲ꦳", //H
      "I": "ꦆ", //I
      "J": "ꦙ", //J
      "K": "ꦑ", //K
      "L": "ꦭ", //L
      "M": "ꦩ", //M
      "N": "ꦟ", //N
      "O": "ꦎ", //O
      "P": "ꦦ", //P
      "Q": "꧀", //Q
      "R": "ꦬ", //R
      "ś": "ꦯ", //ś
      "S": "ꦯ", //S
      "T": "ꦡ", //T
      "U": "ꦈ", //U
      "V": "ꦮ꦳", //V
      "W": "ꦮ", //W
      "X": "ꦼ", //X
      "Y": "ꦪ", //Y
      "Z": "ꦗ꦳", //Z
      "a": "ꦄ", //a
      "b": "ꦧ", //b
      "c": "ꦕ", //c
      "d": "ꦢ", //d
      "e": "ꦌ", //e
      "f": "ꦥ꦳", //f
      "g": "ꦒ", //g
      "h": "ꦃ", //h
      "i": "ꦆ", //i
      "j": "ꦗ", //j
      "k": "ꦏ", //k
      "l": "ꦭ", //l
      "m": "ꦩ", //m
      "n": "ꦤ", //n
      "o": "ꦎ", //o
      "p": "ꦥ", //p
      "q": "꧀", //q
      "r": "ꦂ", //r
      "s": "ꦱ", //s
      "ś": "ꦯ", //ś
      "t": "ꦠ", //t
      "u": "ꦈ", //u
      "v": "ꦮ꦳", //v
      "w": "ꦮ", //w
      "x": "ꦼ", //x
      "ĕ": "ꦼ", //ĕ
      "ě": "ꦼ", //ě
      "ê": "ꦼ", //ê
      "ū": "ꦹ", //ū
      "y": "ꦪ", //y
      "z": "ꦗ꦳", //z
      "È": "ꦌ", //È
      "É": "ꦌ", //É
      "Ê": "ꦄꦼ", //Ê
      "Ě": "ꦄꦼ", //Ě
      "è": "ꦌ", //è
      "é": "ꦌ", //é
      "ṇ": "ꦟ",
      "ḍ": "ꦝ",
      "ṭ": "ꦛ",
      "ṣ": "ꦰ",
      "ṛ": "ꦽ"
    };
    Map<String, String> consonantjavaLatin;

    if (_isMurdha)
      consonantjavaLatin = consonantjavaLatin2;
    else //if(murda == "tidak")
      consonantjavaLatin = consonantjavaLatin1;

    var hShift = _getShift(str);
    var core = str;

    if (hShift.coreSound == null) {
      if (consonantjavaLatin[str[0]] != null) core = consonantjavaLatin[str[0]];
      return CoreSound(coreSound: core, len: 1);
    } else {
      return hShift;
    }
  }

  String _getSpecialSound(String str) {
    Map<String, String> specialsoundjavaLatin = {
      "f": "ꦥ꦳꧀",
      "v": "ꦮ꦳꧀",
      "z": "ꦗ꦳꧀",
      "ś": "ꦯ",
      "q": "꧀" /*pangkon*/
    };
    if (specialsoundjavaLatin[str] != null) {
      return specialsoundjavaLatin[str];
    }
    return null;
  }

  ///  ResolveCharacterSound
  /// return tanda baca, digit, vokal, maupun nglegana+pangkon
  String _resolveCharacterSound(String c) {
    var str = "" + c;
    if (_isDigit(c)) {
      return "" + ('꧇' + c.replaceAll("0", ""));
    } else if (_isHR(str[0])) {
      return "" + _getcoreSound(str).coreSound; //layar dan wignyan
    } else if (_isCJ(str[0])) {
      return "" + _getcoreSound(str).coreSound + "꧀"; //anuswara

    } else if (_isConsonant(str[0])) {
      return "" + _getcoreSound(str).coreSound + "꧀";
    } else {
      //if (isVowel(str[0])) {
      return "" + _getcoreSound(str).coreSound;
    }
/**/
  }

//  GetSound
// fungsi yang mentransliterasi masing-masing suku kata

  String _getSound(String str) {
    str = _superTrim(str);

    if (str == null || str == "") {
      return "";
    }
    var specialSound = _getSpecialSound(str);

    if (specialSound != null && str.length == 1) {
      return specialSound;
    }
    if (str.length == 1) {
      return _resolveCharacterSound(str[0]);
    } else {
      CoreSound coreSound = _getcoreSound(str);
      //return "1"+core_sound.coreSound+"2";
      var matra = "";
      var konsonan = "";
      if (coreSound.len >= 1) {
        matra = _getMatra(str.substring(coreSound
            .len)); //aeiou (suku, wulu, pepet, taling, taling tarung, dll.)

      } else {
        matra = "";
      }

      if (str.indexOf("nggr") == 0) {
        //nggr-
        if (_vowelPrev)
          konsonan = "ꦁꦒꦿ"; //<vowel>nggr-, e.g. panggrahita
        else
          konsonan = "ꦔ꧀ꦒꦿ"; //<nonvowel>nggr-, i.e. nggronjal
      } else if (str.indexOf("nggl") == 0) {
        //nggl-
        konsonan = "ꦔ꧀ꦒ꧀ꦭ";
      } else if (str.indexOf("nggw") == 0) {
        //nggw-
        konsonan = "ꦔ꧀ꦒ꧀ꦮ";
      } else if (str.indexOf("nggy") == 0) {
        //nggy-
        konsonan = "ꦔ꧀ꦒꦾ";
      } else if (str.indexOf("ngg") == 0) {
        //ngg-
        if (_vowelPrev)
          konsonan = "ꦁꦒ"; //<vowel>ngg-, e.g. tunggal
        else
          konsonan = "ꦔ꧀ꦒ"; //<nonvowel>ngg-, i.e. nggambar
      } else if (str.indexOf("ngl") == 0) {
        //ngl-
        konsonan = "ꦔ꧀ꦭ";
      } else if (str.indexOf("ngw") == 0) {
        //ngw-
        konsonan = "ꦔ꧀ꦮ";
      } else if (str.indexOf("ncl") == 0) {
        //ncl-
        konsonan = "ꦚ꧀ꦕ꧀ꦭ";
      } else if (str.indexOf("ncr") == 0) {
        //ncr-
        konsonan = "ꦚ꧀ꦕꦿ";
      } else if (str.indexOf("njl") == 0) {
        //njl-
        konsonan = "ꦚ꧀ꦗ꧀ꦭ";
      } else if (str.indexOf("njr") == 0) {
        //njr-
        konsonan = "ꦚ꧀ꦗꦿ";
      } else if (str.indexOf("ngg") == 0) {
        //ngg-
        if (_vowelPrev)
          konsonan = "ꦁꦒ"; //<vowel>ngg-, e.g. tunggal
        else
          konsonan = "ꦔ꧀ꦒ"; //<nonvowel>ngg-, i.e. nggambar
      } else if (coreSound.coreSound == "ꦤꦚ꧀ꦕ꧀ꦭ") {
        // -ncl-
        konsonan = "ꦚ꧀ꦕ꧀ꦭ"; //-ncl-
      } else if (coreSound.coreSound == "ꦤꦚ꧀ꦕꦿ") {
        // -ncr-
        konsonan = "ꦚ꧀ꦕꦿ"; //-ncr-*/
      } else if (coreSound.coreSound == "ꦤꦚ꧀ꦕ") {
        // -nc-
        konsonan = "ꦚ꧀ꦕ"; //-nyc-/*
      } else if (coreSound.coreSound == "ꦤꦚ꧀ꦗ꧀ꦭ") {
        // -njl-
        konsonan = "ꦚ꧀ꦗ꧀ꦭ"; //-njl-
      } else if (coreSound.coreSound == "ꦤꦚ꧀ꦗꦿ") {
        // -njr-
        konsonan = "ꦚ꧀ꦗꦿ"; //-njr-*/
      } else if (coreSound.coreSound == "ꦤꦚ꧀ꦗ") {
        // -nj-
        konsonan = "ꦚ꧀ꦗ"; //-nyj-
      } else if (coreSound.coreSound == "ꦢꦝ꧀ꦮ") {
        // -dhw-
        konsonan = "ꦝ꧀ꦮ"; //-dhw-
      } else if (coreSound.coreSound == "ꦢꦝꦾ") {
        // -dhy-
        konsonan = "ꦝꦾ"; //-dhy-
      } else if (coreSound.coreSound == "ꦠꦛ꧀ꦮ") {
        // -thw-
        konsonan = "ꦛ꧀ꦮ"; //-dhw-
      } else if (coreSound.coreSound == "ꦠꦛꦾ") {
        // -thy-
        konsonan = "ꦛꦾ"; //-dhy-
      } else if (_findstr(coreSound.coreSound, 'ꦾ') && matra == "꧀") {
        // pengkal
        konsonan = coreSound.coreSound;
        matra = ""; //-y-
      } else if (_findstr(coreSound.coreSound, 'ꦿ') && matra == "꧀") {
        // cakra
        konsonan = coreSound.coreSound;
        matra = ""; //-r-
      } else if (_findstr(coreSound.coreSound, 'ꦿ') && matra == "ꦼ") {
        // cakra keret
        if ((str[0] == "n" && str[1] == "y") ||
            ((str[0] == "t" || str[0] == "d") && str[1] == "h")) {
          konsonan = _getcoreSound(str[0] + str[1]).coreSound + "ꦽ";
          matra = ""; //nyrê-, thrê-, dhrê-
        } else if (str[0] == "n" && str[1] == "g") {
          if (str[2] == "g")
            konsonan = "ꦔ꧀ꦒꦽ";
          else
            konsonan = "ꦔꦽ";
          matra = ""; //nggrê-/ngrê-
        } else {
          konsonan = _getcoreSound(str[0]).coreSound + "ꦽ";
          matra = ""; //-rê-
        }
      } else if (_findstr(coreSound.coreSound, 'ꦭ') && matra == "ꦼ") {
        // nga lelet
        if ((str[0] == "n" && str[1] == "y") ||
            ((str[0] == "t" || str[0] == "d") && str[1] == "h")) {
          konsonan = _getcoreSound(str[0] + str[1]).coreSound + "꧀ꦭꦼ";
          matra = ""; //nylê-, thlê-, dhlê-
        } else if (str[0] == "n" && str[1] == "g") {
          if (str[2] == "g")
            konsonan = "ꦔ꧀ꦒ꧀ꦭꦼ";
          else
            konsonan = "ꦔ꧀ꦭꦼ";
          matra = ""; //ngglê-/nglê-
        } else if (str[0] == "l") {
          konsonan = "ꦊ";
          matra = ""; //-lê-
        } else {
          konsonan = _getcoreSound(str[0]).coreSound + "꧀ꦭꦼ";
          matra = ""; //-lê-
        }
      } else if (coreSound.coreSound == 'ꦛꦿ' ||
          coreSound.coreSound == 'ꦝꦿ' ||
          coreSound.coreSound == 'ꦔꦿ' ||
          coreSound.coreSound == 'ꦚꦿ') {
        // i.e. nyruput
        konsonan = coreSound.coreSound;
        if (matra == "꧀") matra = "";
      } else if (coreSound.coreSound == "ꦭꦭ꧀ꦭ") {
        // -ll-
        konsonan = "ꦭ꧀ꦭ"; //double -l-
      } else if (coreSound.coreSound == "ꦂꦂꦫ") {
        // -rr-
        konsonan = "ꦂꦫ"; //double -r-
      } else if (coreSound.coreSound == "ꦂꦂꦲ") {
        // -rh-
        konsonan = "ꦂꦲ"; //-rh-
      } else if (coreSound.coreSound == "ꦂꦂꦭ") {
        // -rl-
        konsonan = "ꦂꦭ"; //-rl-
      } else if (coreSound.coreSound == "ꦂꦂꦮ") {
        // -rw-
        if (_vowelPrev)
          konsonan = "ꦂꦮ"; //-rw- -- arwana
        else
          konsonan = "ꦫ꧀ꦮ"; //rw- -- rwa/rwi/rwab
      } else if (coreSound.coreSound == "ꦂꦂꦕ") {
        // -rc-
        konsonan = "ꦂꦕ"; //-rc-
      } else if (coreSound.coreSound == "ꦃꦃꦲ") {
        // -hh-
        konsonan = "ꦃꦲ"; //double -h-
      } else if (coreSound.coreSound == "ꦃꦃꦭ") {
        // -hl-
        if (_vowelPrev)
          konsonan = "ꦃꦭ"; //-hl-
        else
          konsonan = "ꦲ꧀ꦭ"; //hlam
      } else if (coreSound.coreSound == "ꦃꦃꦮ") {
        // -hw-
        if (_vowelPrev)
          konsonan = "ꦃꦮ"; //-hw-
        else
          konsonan = "ꦲ꧀ꦮ"; //hwab,hwan
      } else if (coreSound.coreSound == "ꦃꦲꦾ") {
        // -hy-
        if (_vowelPrev)
          konsonan = "ꦃꦪ"; //sembahyang
        else
          konsonan = "ꦲꦾ"; //hyang/*
      } else if (coreSound.coreSound == "ꦃꦃꦽ") {
        // hrx-
        konsonan = "ꦲꦿ"; //hrx-
      } else if (coreSound.coreSound == "ꦃꦃꦿ") {
        // hr-
        if (matra == "ꦼ")
          konsonan = "ꦲꦽ"; //hr-
        else
          konsonan = "ꦲꦿ"; //hr-
      } else if (coreSound.coreSound == "ꦃꦲꦿ") {
        // hr-
        if (matra == "ꦼ")
          konsonan = "ꦲꦽ"; //hr-
        else
          konsonan = "ꦲꦿ"; //hr-
      } else if (coreSound.coreSound == 'ꦃ' && matra == "꧀") {
        // wignyan - 12 April
        konsonan = "ꦲ"; //ha
      } else if (coreSound.coreSound == 'ꦃ' && matra != "꧀") {
        // wignyan
        konsonan = "ꦲ"; //ha
      } else if (coreSound.coreSound == 'ꦂ' && matra == "ꦼ") {
        // pa cerek
        konsonan = "ꦉ";
        matra = ""; //rê
      } else if (coreSound.coreSound == 'ꦂ' && matra != "꧀") {
        // layar
        konsonan = "ꦫ"; //ra
      } else if (coreSound.coreSound == 'ꦁ' && matra != "꧀") {
        // cecak
        konsonan = "ꦔ"; //nga
      } else if (coreSound.coreSound == 'ꦁ' && matra == "꧀") {
        // cecak
        konsonan = "ꦁ";
        matra = ""; //cecak
      } else {
        konsonan = coreSound.coreSound;
      }
      return "" + konsonan + matra;
    }
  }

//  DoTransliterate
// fungsi utama yang dipanggil (main )

  String _transliterateLatinToJava(String str) {
    var i = 0;
    var ret = "";
    var pi = 0; //?offset
    str = _superTrim(str);

    bool vowelFlag = false, angkaFlag = false, cecakFlag = false;
    var angka = {
      "0": '꧐',
      "1": '꧑',
      "2": '꧒',
      "3": '꧓',
      "4": '꧔',
      "5": '꧕',
      "6": '꧖',
      "7": '꧗',
      "8": '꧘',
      "9": '꧙'
    };

    while (i < str.length) {
      if (i > 0 && _isVowel(str[i]) && _isVowel(str[i - 1])) {
        //deal with words that start with multiple vocals
        if ((str[i - 1] == 'a' && str[i] == 'a') ||
            (str[i - 1] == 'i' && str[i] == 'i') ||
            (str[i - 1] == 'u' && str[i] == 'u') ||
            (str[i - 1] == 'a' && str[i] == 'i') ||
            (str[i - 1] == 'a' && str[i] == 'u')) {
          //specials
          if (i == 1 || (i > 1 && !_isConsonant(str[i - 2]))) {
            //for example if starts with 'ai-'
            str = str.substring(0, i) + 'h' + str.substring(i, str.length);
          }
          //else, do nothing, look in matrajavaLatin table
        } else if ((str[i - 1] == 'e' ||
                str[i - 1] == 'è' ||
                str[i - 1] == 'é') &&
            (str[i] == 'a' || str[i] == 'o')) {
          //-y-
          str = str.substring(0, i) + 'y' + str.substring(i, str.length);
        } else if ((str[i - 1] == 'i') &&
            (str[i] == 'a' ||
                str[i] == 'e' ||
                str[i] == 'è' ||
                str[i] == 'é' ||
                str[i] == 'o' ||
                str[i] == 'u')) {
          //-y-
          str = str.substring(0, i) + 'y' + str.substring(i, str.length);
        } else if ((str[i - 1] == 'o') &&
            (str[i] == 'a' ||
                str[i] == 'e' ||
                str[i] == 'è' ||
                str[i] == 'é')) {
          //-w-
          str = str.substring(0, i) + 'w' + str.substring(i, str.length);
        } else if ((str[i - 1] == 'u') &&
            (str[i] == 'a' ||
                str[i] == 'e' ||
                str[i] == 'è' ||
                str[i] == 'é' ||
                str[i] == 'i' ||
                str[i] == 'o')) {
          //-y-
          str = str.substring(0, i) + 'w' + str.substring(i, str.length);
        } else {
          str = str.substring(0, i) + 'h' + str.substring(i, str.length);
        }
      }
      if ((_isSpecial(str[i]) || _isLW(str[i]) || _isCJ(str[i])) &&
          !vowelFlag) {
        //i++;
      } else if ((str[i] == 'h' && vowelFlag) ||
          (!_isVowel(str[i]) && i > 0) ||
          (str[i] == ' ') ||
          _isPunct(str[i]) ||
          _isDigit(str[i]) ||
          ((i - pi) > 5)) {
        if (!_isDigit(str[i]) && angkaFlag) {
          //turn off the flag
          ret += "꧇​"; // with zws
          angkaFlag = false;
        }
        if (pi < i) {
          if (cecakFlag && _getSound(str.substring(pi, i)) == "ꦁ") {
            cecakFlag = false;
            ret += "ꦔ꧀ꦔ";
          } else if (!cecakFlag && _getSound(str.substring(pi, i)) == "ꦁ") {
            cecakFlag = true;
            ret += "ꦁ";
          } else {
            cecakFlag = false;
            ret += _getSound(str.substring(pi, i));
          }
        }
        if (str[i] == ' ') {
          var spasi;
          if (_isSpasi) {
            spasi = '';
          } else {
            //if(mode == "with")
            spasi = '​'; // zero-width space
            //spasi = ' '; }//hair space http://en.wikipedia.org/wiki/Space_(punctuation)#Spaces_in_Unicode
          }
          ret += spasi;
        }
        if (_isPunct(str[i])) {
          if (str[i] == '.') {
            ret += "꧉​"; //titik+zero-width space
            pi = i + 1;
          } else if (str[i] == ',') {
            ret += "꧈​"; //koma+zero-width space
            pi = i + 1;
          } else if (str[i] == '|') {
            ret += "꧋";
            pi = i + 1;
          } else if (str[i] == '(') {
            ret += "꧌";
            pi = i + 1;
          } else if (str[i] == ')') {
            ret += "꧍​";
            pi = i + 1; // with zws
          } else if (str[i] == '-') {
            //tanda hubung
            ret += "​";
            pi = i + 1;
          } else if (str[i] == '?' ||
              str[i] == '!' ||
              str[i] == '"' ||
              str[i] == "'") {
            //tanda tanya/seru/petik
            ret += "​"; //zero-width space
            pi = i + 1;
          } else {
            ret += str[i];
            pi = i + 1;
          }
        } else if (_isDigit(str[i])) {
          if (!angkaFlag) ret += "꧇";
          ret += angka[str[i]];
          angkaFlag = true;
          pi = i + 1;
        } else {
          pi = i;
        }
        vowelFlag = false;
      } else if (_isVowel(str[i]) && str[i] != 'h') {
        if (!_isDigit(str[i]) && angkaFlag) {
          //turn off the flag
          ret += "꧇​"; //with zws
          angkaFlag = false;
        }
        vowelFlag = true;
      }
      if (pi > 0 && _isVowel(str[pi - 1])) {
        //<vowel>ngg
        _vowelPrev = true;
      } else {
        _vowelPrev = false;
      }
      i++;
    } //endwhile
    if (pi < i) {
      ret += _getSound(str.substring(pi, i));
    }
    return _superTrim(ret);
  }
}

class CoreSound {
  String coreSound;
  int len;

  CoreSound({
    this.coreSound,
    this.len,
  });
}
