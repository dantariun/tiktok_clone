import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo(String title, String description) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    // final newVideo = VideoModel(
    //   title: "${DateTime.now()}",
    //   description: '',
    //   fileUrl: '',
    //   thumbnailUrl: '',
    //   creatorUid: '',
    //   creator: '',
    //   likes: 0,
    //   comments: 0,
    //   createAt: 0,
    // );
    _list = [
      ..._list,
    ];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
        () => TimelineViewModel());
