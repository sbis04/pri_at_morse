import 'package:at_commons/at_commons.dart';
import 'package:primorse/services/server_demo_service.dart';
import 'package:primorse/extensions/morse.dart';
import '../utils/configure.dart' as conf;

class Database {
  ServerDemoService _atClientService = ServerDemoService.getInstance();

  Future<void> storeData({String message, String messageTo, String messageFrom}) async {
    if (message != null) {
      DateTime currentTimestamp = DateTime.now();

      print(currentTimestamp.millisecondsSinceEpoch.toString());

      AtKey pair = AtKey()
        ..key = '${currentTimestamp.millisecondsSinceEpoch}'
        ..sharedBy = messageFrom
        ..sharedWith = messageTo;

      await _atClientService.put(pair, message);
    }
  }

  Future<List<Map<String, String>>> retrieveData(
    String myAtSign,
    String otherAtSign,
  ) async {
    // print('HELLO:$sharedBySign');
    List<Map<String, String>> mapList = [];
    List<String> myList;
    // List<String> otherList;

    List<String> myResponse = await _atClientService.getKeys(sharedBy: myAtSign);
    List<String> otherResponse = await _atClientService.getKeys(sharedBy: otherAtSign);
    // print('.' + conf.namespace + sharedBySign);

    print('MY RESPONSE: $myResponse');
    print('OTHER RESPONSE: $otherResponse');

    if (myResponse.length > 0) {
      myList = myResponse.map((key) {
        print('MY KEY:$key');
        return key
            .replaceAll('.' + conf.namespace + myAtSign, '')
            .replaceAll(otherAtSign + ':', '');
      }).toList();

      for (int i = 0; i < myList.length; i++) {
        String message = await lookUpValue(myList[i], myAtSign, otherAtSign);
        // print(message);
        Map<String, String> map = {
          'timestamp': myList[i],
          'from': myAtSign,
          'to': otherAtSign,
          'content': message,
          'morse': message.toMorse(),
        };

        mapList.add(map);
      }

      print('MY LIST: $myList');
    } else {
      myList = [];
    }

    if (otherResponse.length > 0) {
      List<String> otherList = otherResponse.map((key) {
        print('OTHER KEY:$key');
        return key.replaceAll('.' + conf.namespace + otherAtSign, '');
        // .replaceAll(myAtSign + ':', '');
      }).toList();

      // print(otherList.length);
      print('OTHER LIST:: $otherList');

      for (int i = 0; i < otherList.length; i++) {
        String message = await lookUpValue(otherList[i], otherAtSign, myAtSign);
        print(message);
        Map<String, String> map = {
          'timestamp': otherList[i],
          'from': otherAtSign,
          'to': myAtSign,
          'content': message,
          'morse': message.toMorse(),
        };

        mapList.add(map);
      }

      print('OTHER LIST: $otherList');
    }

    mapList.sort((a, b) => (int.parse(b['timestamp'])).compareTo(int.parse(a['timestamp'])));

    print(mapList);

    return mapList;
  }

  Future<String> lookUpValue(String messageKey, String sharedFrom, String sharedTo) async {
    print(messageKey);
    if (messageKey != null) {
      AtKey lookup = AtKey()
        ..key = messageKey
        ..sharedBy = sharedFrom
        ..sharedWith = sharedTo;

      String response = await _atClientService.get(lookup);

      if (response != null) {
        return response;
      }
    }
    return null;
  }
}
