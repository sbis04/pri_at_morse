class MorseBrain {
  static final Map<String, String> _morseCharacterDictionary = {
    'a': '.-',
    'b': '-...',
    'c': '-.-.',
    'd': '-..',
    'e': '.',
    'f': '..-.',
    'g': '--.',
    'h': '....',
    'i': '..',
    'j': '.---',
    'k': '-.-',
    'l': '.-..',
    'm': '--',
    'n': '-.',
    'o': '---',
    'p': '.--.',
    'q': '--.-',
    'r': '.-.',
    's': '...',
    't': '-',
    'u': '..-',
    'v': '...-',
    'w': '.--',
    'x': '-..-',
    'y': '-.--',
    'z': '--..',
    '0': '-----',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '&': '.-...',
    '\'': '.----.',
    '@': '.--.-.',
    ')': '-.--.-',
    '(': '-.--.',
    ':': '---...',
    ',': '--..--',
    '=': '-...-',
    '!': '-.-.--',
    '.': '.-.-.-',
    '-': '-....-',
    '+': '.-.-.',
    '"': '.-..-.',
    '?': '..--..',
    '/': '-..-.',
  };

  static String parseCharacter(String morseCharacter) {
    if (_morseCharacterDictionary.containsValue(morseCharacter)) {
      return _morseCharacterDictionary.keys
          .firstWhere((k) => _morseCharacterDictionary[k] == morseCharacter, orElse: () => null);
    } else {
      return 'unknown';
    }
  }

  static parseMorse(String alphabetCharacter) {
    return _morseCharacterDictionary.containsKey(alphabetCharacter)
        ? _morseCharacterDictionary[alphabetCharacter]
        : alphabetCharacter;
  }
}
