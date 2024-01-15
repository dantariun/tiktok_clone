import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/user/view_models/info_view_model.dart';

class UserInfoEditScreen extends ConsumerStatefulWidget {
  final String bio;
  final String link;
  const UserInfoEditScreen({
    super.key,
    required this.bio,
    required this.link,
  });

  @override
  ConsumerState<UserInfoEditScreen> createState() => _UserInfoEditScreenState();
}

class _UserInfoEditScreenState extends ConsumerState<UserInfoEditScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  String _bio = "";
  String _link = "";

  @override
  void initState() {
    super.initState();

    _bioController.addListener(() {
      _bio = _bioController.text;
      setState(() {});
    });

    _linkController.addListener(() {
      _link = _linkController.text;
      setState(() {});
    });

    _bioController.value = TextEditingValue(text: widget.bio);
    _linkController.value = TextEditingValue(text: widget.link);
  }

  Future<void> _updateBio() async {
    ref.read(userInfoProvider.notifier).uploadBio(_bio);
  }

  Future<void> _updateLink() async {
    ref.read(userInfoProvider.notifier).uploadLink(_link);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userInfoProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text("BIO"),
            ListTile(
              contentPadding: null,
              title: TextField(
                minLines: 1,
                maxLines: 3,
                controller: _bioController,
              ),
              trailing: IconButton(
                onPressed: isLoading ? null : _updateBio,
                icon: isLoading
                    ? const CircularProgressIndicator()
                    : const FaIcon(
                        FontAwesomeIcons.penToSquare,
                      ),
              ),
            ),
            Gaps.v40,
            const Text("LINK"),
            ListTile(
              title: TextField(
                minLines: 1,
                maxLines: 3,
                controller: _linkController,
              ),
              trailing: IconButton(
                onPressed: isLoading ? null : _updateLink,
                icon: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
