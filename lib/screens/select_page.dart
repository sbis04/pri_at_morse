import 'package:flutter/material.dart';
import 'package:primorse/res/custom_colors.dart';
import 'package:primorse/screens/chat_page.dart';

class SelectPage extends StatefulWidget {
  final String currentUserAtSign;

  const SelectPage({@required this.currentUserAtSign});

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  TextEditingController _textControllerAtSign = TextEditingController();
  FocusNode _textFocusNodeAtSign = FocusNode();

  bool _isEditingAtSign = false;

  String _validateString(String value) {
    value = value.trim();

    if (_textControllerAtSign.text != null) {
      if (value.isEmpty) {
        return '@sign can\'t be empty';
      } else if (value.trim().contains(' ')) {
        return '@sign can\'t contain a space';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _textFocusNodeAtSign.unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Who do you want to chat with?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _textControllerAtSign,
                  focusNode: _textFocusNodeAtSign,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  cursorColor: CustomColors.highlight,
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      _isEditingAtSign = true;
                    });
                  },
                  onSubmitted: (value) {
                    _textFocusNodeAtSign.unfocus();
                  },
                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 16.0),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: CustomColors.medium,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: CustomColors.medium,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: CustomColors.highlight,
                        width: 3,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    hintText: "Enter the other person's @sign",
                    fillColor: Colors.white24,
                    prefix: Text(
                      '@ ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                      ),
                    ),
                    errorText:
                        _isEditingAtSign ? _validateString(_textControllerAtSign.text) : null,
                    errorStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.maxFinite,
                  child: RaisedButton(
                    color: CustomColors.highlight,
                    onPressed:
                        _textControllerAtSign.text != null && _textControllerAtSign.text != ''
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      userAtSign: widget.currentUserAtSign,
                                      otherAtSign: _textControllerAtSign.text,
                                    ),
                                  ),
                                );
                              }
                            : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Text(
                        'START',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: _textControllerAtSign.text != null &&
                                  _textControllerAtSign.text != ''
                              ? CustomColors.dark
                              : CustomColors.medium,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
