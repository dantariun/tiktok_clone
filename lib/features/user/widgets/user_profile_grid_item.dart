import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class UserProfileGridItem extends StatelessWidget {
  final String img;
  final String count;
  const UserProfileGridItem({
    super.key,
    required this.img,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 9 / 12,
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: "assets/image/placeholder.jpg",
            image:
                "https://images.unsplash.com/photo-1693495430456-25c0a37ec5dc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2160&q=80",
          ),
        ),
        Gaps.v10,
        const Positioned(
          left: Sizes.size5,
          bottom: Sizes.size5,
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.circlePlay,
                color: Colors.white,
                size: Sizes.size14,
              ),
              Gaps.h5,
              Text(
                "4.1M",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
