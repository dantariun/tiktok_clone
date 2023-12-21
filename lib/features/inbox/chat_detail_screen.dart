import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/util/global_util.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: isDark ? null : Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: isDark ? null : Colors.grey.shade100,
          surfaceTintColor: isDark ? null : Colors.grey.shade100,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: Sizes.size20,
                    foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/3612017"),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ],
            ),
            title: Text(
              "니꼬 ${widget.chatId}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text("Active now"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.flag,
                  color: isDark ? null : Colors.black,
                  size: Sizes.size20,
                ),
                Gaps.h32,
                FaIcon(
                  FontAwesomeIcons.ellipsis,
                  color: isDark ? null : Colors.black,
                  size: Sizes.size20,
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                  horizontal: Sizes.size14,
                ),
                itemBuilder: (context, index) {
                  final bool isMine = index % 2 == 0;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: isMine
                                ? Colors.blue
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: isMine
                                  ? const Radius.circular(20)
                                  : const Radius.circular(1),
                              bottomRight: isMine
                                  ? const Radius.circular(1)
                                  : const Radius.circular(20),
                            )),
                        child: const Text(
                          "This is a message",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 10),
            Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: BottomAppBar(
                  color: isDark ? null : Colors.grey.shade100,
                  surfaceTintColor: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(0),
                                ),
                                borderSide: BorderSide.none),
                            hintText: "Send a message...",
                            hintStyle: TextStyle(
                              color: isDark ? null : Colors.grey.shade500,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const FaIcon(FontAwesomeIcons.faceSmile),
                            ),
                            filled: true,
                            fillColor:
                                isDark ? Colors.grey.shade800 : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                              vertical: Sizes.size10,
                            ),
                          ),
                        ),
                      ),
                      Gaps.h20,
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: isDark ? Colors.grey.shade800 : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
