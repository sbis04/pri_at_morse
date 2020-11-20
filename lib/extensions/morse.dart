import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:primorse/utils/morse_brain.dart';

/// `INTERNATIONAL MORSE TRANSLATION FORMAT`
/// (enhanced version to support `capitalizaion` and proper `spacing`)
///
/// Information regarding morse translation:
///
/// * First two characters for checking `capitalization`
/// * Next for checking the `alphabet`
/// * Then `word/letter separator`
///
/// * `"/"` word or character separator
/// * `" "` letter separator
///
/// `"--"` small
/// `".."` capital
///

extension StringExtension on String {
  String decryptMorse() {
    String fullString = this;
    String finalString = '';

    List<String> wordsOrCharacters = fullString.split('/');

    for (int k = 0; k < wordsOrCharacters.length; k++) {
      String eachWordOrCharacter = wordsOrCharacters[k];
      List<String> charactersInAWord = eachWordOrCharacter.split(' ');
      String word = '';

      for (String eachCharacter in charactersInAWord) {
        String capitalizationCheckerString = eachCharacter.substring(0, 2);

        String actualLetterInMorse = eachCharacter.substring(2);

        String parsedCharacter = MorseBrain.parseCharacter(actualLetterInMorse);

        if (capitalizationCheckerString == '..') {
          parsedCharacter = parsedCharacter.toUpperCase();
        }

        word += parsedCharacter;
      }

      if (k != wordsOrCharacters.length - 1) word += ' ';

      finalString += word;
    }

    return finalString;
  }

  String toMorse() {
    String fullString = this;
    String finalString = '';

    var parser = EmojiParser();

    fullString = parser.unemojify(fullString);

    List<String> words = fullString.split(' ');

    for (int k = 0; k < words.length; k++) {
      String eachWord = words[k];
      List<String> letters = eachWord.split('');
      String morseWord = '';

      for (int i = 0; i < letters.length; i++) {
        String letter = letters[i];

        if (letter.toUpperCase() == letter) {
          morseWord += '..';
        } else {
          morseWord += '--';
        }
        morseWord += MorseBrain.parseMorse(letter.toLowerCase());

        if (i != letters.length - 1) {
          morseWord += ' ';
        }
      }

      if (k != words.length - 1) morseWord += '/';
      finalString += morseWord;
    }

    return finalString;
  }
}
