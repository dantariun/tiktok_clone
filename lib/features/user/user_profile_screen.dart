import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/user/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/user/widgets/user_profile_grid_item.dart';
import 'package:tiktok_clone/features/user/widgets/user_profile_like_item.dart';
import 'package:tiktok_clone/util/global_util.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: widget.tab == "likes" ? 1 : 0,
          length: 2,
          child: NestedScrollView(
            body: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.zero,
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: Sizes.size2,
                      mainAxisSpacing: Sizes.size2,
                      childAspectRatio: 9 / 12),
                  itemBuilder: (context, index) =>
                      const UserProfileGridItem(img: "", count: ""),
                ),
                const Center(
                  child: Text("Two"),
                ),
              ],
            ),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  // leading:
                  //     const Center(child: FaIcon(FontAwesomeIcons.chevronLeft)),
                  title: Text(
                    widget.username,
                  ),
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gaps.v20,
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: isDark ? Colors.grey.shade400 : null,
                        child: const Text("보현"),
                      ),
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${widget.username}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          Gaps.h6,
                          FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            size: Sizes.size18,
                            color: Colors.blue.shade600,
                          )
                        ],
                      ),
                      Gaps.v24,
                      SizedBox(
                        height: Sizes.size48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const UserProfileLikeItem(
                              count: "97",
                              title: "Following",
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: 1,
                              color: Colors.grey.shade400,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            const UserProfileLikeItem(
                              count: "10M",
                              title: "Followers",
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: 1,
                              color: Colors.grey.shade400,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            const UserProfileLikeItem(
                              count: "194.3M",
                              title: "Likes",
                            ),
                          ],
                        ),
                      ),
                      Gaps.v10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size52,
                              vertical: Sizes.size12,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(
                                Sizes.size4,
                              ),
                            ),
                            child: const Text(
                              "Follow",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Gaps.h4,
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  Sizes.size4,
                                )),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.youtube,
                                size: Sizes.size20,
                              ),
                            ),
                          ),
                          Gaps.h4,
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  Sizes.size4,
                                )),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.sortDown,
                                size: Sizes.size20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v14,
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size32,
                        ),
                        child: Text(
                          "All highlights and where to watch live matches on FIFA+ EA Sport to the game.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v14,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.link,
                            size: Sizes.size12,
                          ),
                          Gaps.h4,
                          Text(
                            "http://nomardcoder.co",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Gaps.v5,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
