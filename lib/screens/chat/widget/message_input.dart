import 'package:flutter/material.dart';

import '../../../../helpers/ui_data.dart';

class MessageInput extends StatefulWidget {
  final String? placeholder;
  final VoidCallback? onPressPlus;
  final Function(String) onPressSend;
  final Function(String?)? onEditing;
  final Function(String) onChanged;
  final bool? isEditing;

  MessageInput({
    this.placeholder,
    this.onPressPlus,
    required this.onPressSend,
    required this.onChanged,
    this.onEditing,
    this.isEditing = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final inputController = TextEditingController();
  bool shouldShowSendButton = false;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    isEditing = widget.isEditing ?? false;

    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      color: Colors.white,
      child: Column(
        children: [
          _buildMainInput(context),
          SizedBox(height: 8),
          // if (isEditing) _buildAccessoryView(context),
        ],
      ),
    );
  }

  Widget _buildMainInput(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 20),
        if (!isEditing)
          Container(
            margin: EdgeInsets.only(right: 8, bottom: 3),
            padding: EdgeInsets.all(4),
            height: 32,
            width: 32,
            child: FloatingActionButton(
              onPressed: widget.onPressPlus,
              child: Image(
                image: AssetImage('assets/iconAdd@3x.png'),
                fit: BoxFit.scaleDown,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: UIColor.cGrey50),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: TextField(
              maxLines: 5,
              minLines: 1,
              // textAlignVertical: TextAlignVertical.bottom,
              controller: inputController,
              decoration: const InputDecoration(
                // hintText: "Type a message",
                // hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                  //borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                // contentPadding: EdgeInsets.only(top: 2),
              ),
              onChanged: (text) {
                widget.onChanged(text);
                setState(() {
                  shouldShowSendButton = text != '';
                });
              },
            ),
          ),
        ),
        if (shouldShowSendButton && !isEditing)
          Container(
            margin: EdgeInsets.only(left: 8, right: 12, bottom: 8),
            child: FloatingActionButton(
              onPressed: () {
                widget.onPressSend(inputController.text);
                inputController.clear();
                setState(() {
                  shouldShowSendButton = false;
                });
              },
              child: Image(
                image: AssetImage('assets/iconSend@3x.png'),
                fit: BoxFit.scaleDown,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            width: 24,
            height: 24,
          )
        else
          SizedBox(width: 16)
      ],
    );
  }

  // Widget _buildAccessoryView(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         TextButton(
  //           onPressed: () {
  //             if (widget.onEditing != null) widget.onEditing!(null);
  //             inputController.clear();
  //             setState(() {
  //               shouldShowSendButton = false;
  //               isEditing = false;
  //             });
  //           },
  //           child: Text(
  //             'Cancel',
  //             style: TextStyles.sendbirdButtonPrimary300,
  //           ),
  //         ),
  //         RaisedButton(
  //           onPressed: () {
  //             if (widget.onEditing != null)
  //               widget.onEditing!(inputController.text);
  //             inputController.clear();
  //             setState(() {
  //               shouldShowSendButton = false;
  //               isEditing = false;
  //             });
  //           },
  //           child: Text('Save', style: TextStyles.sendbirdButtonOnDark1),
  //           color: SBColors.primary_300,
  //           textColor: Colors.white,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(4.0),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
