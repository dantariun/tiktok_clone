import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class DiscoverSearchTextfield extends StatefulWidget {
  const DiscoverSearchTextfield({super.key});

  @override
  State<DiscoverSearchTextfield> createState() =>
      _DiscoverSearchTextfieldState();
}

class _DiscoverSearchTextfieldState extends State<DiscoverSearchTextfield> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      if (_textEditingController.text != "") {
        _isWriting = true;
      } else {
        _isWriting = false;
      }
      setState(() {});
    });
  }

  void _onClearTextTap() {
    _textEditingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              expands: true,
              minLines: null,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                icon: const FaIcon(FontAwesomeIcons.chevronLeft),
                prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: Sizes.size20,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Sizes.size12,
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size12,
                  vertical: Sizes.size10,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    right: Sizes.size14,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isWriting)
                        Row(
                          children: [
                            Gaps.h14,
                            GestureDetector(
                              onTap: _onClearTextTap,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: Sizes.size16),
            child: FaIcon(FontAwesomeIcons.barsProgress),
          )
        ],
      ),
    );
  }
}
