import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/util/global_util.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class DiscoverGridItem extends StatelessWidget {
  const DiscoverGridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Column(
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
                const Text(
                  "This is very long caption for my tiktok that im upload just now currently",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v5,
                // if (constraints.maxWidth > 250)
                DefaultTextStyle(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode(context)
                        ? Colors.grey.shade300
                        : Colors.grey.shade600,
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        child: Text("P"),
                      ),
                      Gaps.h5,
                      const Expanded(
                        child: Text(
                          "Pepper kim. Great Developer",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gaps.h4,
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: Sizes.size16,
                        color: Colors.grey.shade600,
                      ),
                      Gaps.h2,
                      const Text(
                        "2.9M",
                      )
                    ],
                  ),
                )
              ],
            ));
  }
}
