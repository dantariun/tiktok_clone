import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/break_points.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/widgets/discover_grid_item.dart';
import 'package:tiktok_clone/features/discover/widgets/discover_search_textfield.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _onSearchChanged(String value) {
    print("_onSearchChanged $value");
  }

  void _onSearchSubmitted(String value) {
    print("_onSearchSubmitted $value");
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          elevation: 1,
          // title: ConstrainedBox(
          //   constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
          //   child: CupertinoSearchTextField(
          //     onChanged: _onSearchChanged,
          //     onSubmitted: _onSearchSubmitted,
          //   ),
          // ),
          title: Container(
              constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
              child: const DiscoverSearchTextfield()),
          bottom: TabBar(
            controller: _tabController,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            splashFactory: NoSplash.splashFactory,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: Sizes.size16),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                )
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(Sizes.size6),
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20),
            itemBuilder: (context, index) => const DiscoverGridItem(),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(
                  fontSize: Sizes.size56,
                ),
              ),
            )
        ]),
      ),
    );
  }
}
