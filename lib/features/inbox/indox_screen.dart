import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/route_names.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});
  void _onDmPressed(BuildContext context) {
    context.pushNamed(RouteNames.chatsName);
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(RouteNames.activityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey.shade50,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Inbox",
        ),
        actions: [
          IconButton(
              onPressed: () => _onDmPressed(context),
              icon: const FaIcon(FontAwesomeIcons.paperPlane))
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            title: const Text(
              "Activity",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: Sizes.size14,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: Sizes.size14,
              ),
            ),
            subtitle: const Text(
              'Messages from followers will appear here',
              style: TextStyle(
                fontSize: Sizes.size12,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
