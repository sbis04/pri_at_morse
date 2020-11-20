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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(),
    );
  }
}
