import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repository.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreateAt}) async {
    final result = await _repository.fetchVideos(
      lastItemCreatedAt: lastItemCreateAt,
    );
    final videos = result.docs.map(
      (doc) => VideoModel.fromjson(
        json: doc.data(),
        videoId: doc.id,
      ),
    );
    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);
    _list = await _fetchVideos(lastItemCreateAt: null);
    return _list;
  }

  Future<void> fetchNextPagge() async {
    final nextPage = await _fetchVideos(lastItemCreateAt: _list.last.createAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreateAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
        () => TimelineViewModel());
