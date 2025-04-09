import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  int _itemCount = 0;

  final Duration _duration = const Duration(milliseconds: 200);
  final Curve _curve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _duration,
      curve: _curve,
    );
    if (page == _itemCount - 1) {
      ref.watch(timelineProvider.notifier).fetchNextPagge();
    }
  }

  void _onVideoFinished() {
    return;
    // _pageController.nextPage(
    //   duration: _duration,
    //   curve: _curve,
    // );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text("Could not load videos : $error"),
          ),
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              displacement: 50,
              edgeOffset: 20,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                      onVideoFinished: _onVideoFinished,
                      index: index,
                      videoData: videoData);
                },
              ),
            );
          },
        );
  }
}
