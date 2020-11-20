import 'package:at_commons/at_commons.dart';
import 'package:primorse/services/server_demo_service.dart';
import 'package:primorse/extensions/morse.dart';
import '../utils/configure.dart' as conf;

class Database {
  ServerDemoService _atClientService = ServerDemoService.getInstance();

  Future<void> storeData({String message, String messageTo, String messageFrom}) async {
    if (message != null) {
      AtKey pair = AtKey();
      pair.key = message;
      pair.sharedBy = messageFrom;
      pair.sharedWith = messageTo;
      await _atClientService.put(pair, message.toMorse());
    }
  }

  Future<List<Map<String, String>>> retrieveData(String sharedBySign) async {
    List<Map<String, String>> mapList = [];
    List<String> scanList;
    List<String> response = await _atClientService.getKeys(sharedBy: sharedBySign);
    print('.' + conf.namespace + sharedBySign);
    if (response.length > 0) {
      scanList = response
          .map((key) => key
              .replaceAll('.' + conf.namespace + sharedBySign, '')
              .replaceAll(sharedBySign + ':', ''))
          .toList();

      for (int i = 0; i < scanList.length; i++) {
        String morseString = await lookUpValue(scanList[i], sharedBySign);
        print(morseString);
        Map<String, String> map = {
          'content': scanList[i],
          'morse': scanList[i].toMorse(),
        };

        mapList.add(map);
      }

      print(scanList);
    } else {
      scanList = [];
    }
    return mapList;
  }

  Future<String> lookUpValue(String messageKey, String sharedFrom) async {
    if (messageKey != null) {
      AtKey lookup = AtKey();
      lookup.key = messageKey;
      lookup.sharedWith = sharedFrom;

      String response = await _atClientService.get(lookup);

      if (response != null) {
        return response;
      }
    }
    return null;
  }
}
