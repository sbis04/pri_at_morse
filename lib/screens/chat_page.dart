import 'package:flutter/material.dart';
import 'package:primorse/res/custom_colors.dart';
import 'package:primorse/utils/database.dart';

class ChatPage extends StatefulWidget {
  final String userAtSign;
  final String otherAtSign;

  const ChatPage({this.userAtSign, this.otherAtSign});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Database database = Database();

  TextEditingController _textControllerMessage;
  FocusNode _textFocusNodeMessage;

  String _textMessage;

  bool _isStoring = false;
  bool showMorse = false;

  @override
  void initState() {
    _textControllerMessage = TextEditingController();
    _textFocusNodeMessage = FocusNode();
    _textMessage = '';
    // KeyboardVisibilityNotification().addNewListener(
    //   onHide: () {
    //     _textFocusNodeMessage.unfocus();
    //   },
    // );
    // database.updateCurrentlyChattingWith(widget.uid);
    // KeyboardVisibility.onChange.listen((bool visible) {
    //   print('Keyboard visibility update. Is visible: $visible');
    //   if (!visible) {
    //     _textFocusNodeMessage.unfocus();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _textFocusNodeMessage.unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.background,
        appBar: AppBar(
          backgroundColor: CustomColors.dark,
          centerTitle: false,
          title: Text(
            '${widget.otherAtSign}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  if (showMorse)
                    setState(() {
                      showMorse = false;
                    });
                  else
                    setState(() {
                      showMorse = true;
                    });
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: CustomColors.highlight,
                  child: Text(
                    'M',
                    style: TextStyle(color: CustomColors.dark),
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            child: Column(
              children: [
                Row(),
                Container(
                  height: 26,
                  width: double.maxFinite,
                  color: CustomColors.highlight,
                  child: Center(child: Text('Using P2P encryption by @sign')),
                ),
              ],
            ),
            preferredSize: Size(double.maxFinite, 26),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: database.retrieveData(widget.otherAtSign),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, String>> messageListMap = snapshot.data;
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        String morseValue = messageListMap[index]['morse'] ?? '---';
                        String message = messageListMap[index]['content'];

                        return Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: screenWidth / 1.5,
                                  color: CustomColors.medium,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      showMorse ? morseValue : message,
                                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(CustomColors.highlight),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: CustomColors.dark,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: TextField(
                        controller: _textControllerMessage,
                        focusNode: _textFocusNodeMessage,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        cursorColor: CustomColors.highlight,
                        autofocus: false,
                        onChanged: (value) {
                          setState(() {
                            _textMessage = value;
                          });
                        },
                        onSubmitted: (value) {
                          _textFocusNodeMessage.unfocus();
                        },
                        style: TextStyle(color: Colors.white),
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: CustomColors.highlight,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: CustomColors.highlight,
                              width: 3,
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          hintText: "Type a message",
                          fillColor: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 0.0),
                    child: _isStoring
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              CustomColors.highlight,
                            ),
                          )
                        : CircleAvatar(
                            radius: 22,
                            backgroundColor: _textMessage != ''
                                ? CustomColors.highlight.withOpacity(0.2)
                                : Colors.white12,
                            child: IconButton(
                              color: CustomColors.highlight,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Icon(
                                  Icons.send,
                                ),
                              ),
                              disabledColor: Colors.white24,
                              onPressed: _textMessage != ''
                                  ? () async {
                                      setState(() {
                                        _isStoring = true;
                                      });

                                      await database
                                          .storeData(
                                              message: _textMessage,
                                              messageFrom: widget.userAtSign,
                                              messageTo: widget.otherAtSign)
                                          .whenComplete(() {
                                        setState(() {
                                          _isStoring = false;
                                        });
                                      });

                                      // database.sendMessage(
                                      //   widget.uid,
                                      //   _textMessage,
                                      // );

                                      _textControllerMessage.clear();
                                      _textMessage = '';

                                      setState(() {});
                                    }
                                  : null,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
