import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants.dart';
import '../utils.dart';

class AddTokenFormScreen extends StatefulWidget {
  final String current_token_id;
  final String current_token_url;
  final String current_token_push_key;
  final String currentText;
  final bool isAddButtonVisible;

  const AddTokenFormScreen({
    Key? key,
    required this.current_token_url,
    required this.current_token_id,
    required this.current_token_push_key,
    required this.currentText,
    required this.isAddButtonVisible,
  }) : super(key: key);

  @override
  _AddTokenFormScreenState createState() => _AddTokenFormScreenState();
}

class _AddTokenFormScreenState extends State<AddTokenFormScreen> {
  late TextEditingController _controllerTokenId;
  late TextEditingController _controllerTokenUrl;
  final _numberTextInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  late String currentText;
  late bool isAddButtonVisible;

  @override
  void initState() {
    super.initState();
    _controllerTokenId = TextEditingController(text: widget.current_token_id ?? '');
    _controllerTokenUrl = TextEditingController(text: widget.current_token_url ?? '');
    currentText = widget.currentText;
    isAddButtonVisible = widget.isAddButtonVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: TextField(
            controller: _controllerTokenId,
            inputFormatters: [_numberTextInputFormatter],
            decoration: InputDecoration(
              border: null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.2, strokeAlign: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue.shade900,
                  width: 0.2,
                ),
              ),
              hintText: 'Token id',
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FormTextField('Token url', _controllerTokenUrl),
        SizedBox(
          height: 40,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () {
              String _url = _controllerTokenUrl.text;
              String _id = _controllerTokenId.text;

              if (_id.isEmpty) return;
              if (_url.isEmpty) return;

              String pushKey = widget.current_token_push_key == ''
                  ? databaseReference.child(CHILD_TOKENS).push().key.toString()
                  : widget.current_token_push_key;

              databaseReference.child(CHILD_TOKENS).child(pushKey).set({"id": _id, "url": _url});
              setState(() {
                isAddButtonVisible = true;
                currentText = TEXT_TOKENS;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              'Add',
              style: TextStyle(color: Colors.blue, fontSize: 12, decoration: TextDecoration.none),
            ),
          ),
        )
      ],
    );
  }
}
