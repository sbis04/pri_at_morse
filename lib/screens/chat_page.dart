import 'package:flutter/material.dart';
import 'package:primorse/res/custom_colors.dart';

class ChatPage extends StatefulWidget {
  final String userAtSign;
  final String otherAtSign;

  const ChatPage({this.userAtSign, this.otherAtSign});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textControllerMessage;
  FocusNode _textFocusNodeMessage;

  String _textMessage;

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
            '@ ${widget.otherAtSign}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
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
            Expanded(child: Container()),
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
                    child: CircleAvatar(
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
                            ? () {
                                // database.sendMessage(
                                //   widget.uid,
                                //   _textMessage,
                                // );

                                // _textControllerMessage.clear();
                                // _textMessage = '';

                                // setState(() {});
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
