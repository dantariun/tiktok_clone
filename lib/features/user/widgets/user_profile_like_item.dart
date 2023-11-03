import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class UserProfileLikeItem extends StatelessWidget {
  final String count;
  final String title;
  const UserProfileLikeItem({
    super.key,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Sizes.size16,
          ),
        ),
        Gaps.v3,
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        )
      ],
    );
  }
}
