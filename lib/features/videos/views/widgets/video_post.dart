import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'video_button.dart';
import 'video_comments.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/video/FastForwardChallenge.mp4");

  final Duration _animationDuration = const Duration(milliseconds: 200);
  bool isPaused = false;
  bool _isMuted = false;
  bool _isLiked = false;
  int likeCount = 0;

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onLikeTap() async {
    await ref.read(videoPostProvider(widget.videoData.id).notifier).likeVideo();
    if (_isLiked) {
      likeCount--;
    } else {
      likeCount++;
    }
    _isLiked = !_isLiked;
    setState(() {});
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    likeCount = widget.videoData.likes;
    _setVideoVolume();

    if (kIsWeb) {
      _isMuted = true;
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChanged);
    _isLiked = await ref
        .read(videoPostProvider(widget.videoData.id).notifier)
        .isLikedVideo();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _isMuted = ref.read(playbackConfigProvider).muted;

    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  void _setVideoVolume() {
    if (_isMuted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !isPaused) {
      if (ref.read(playbackConfigProvider).autoPlay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      isPaused = !isPaused;
    });
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => const VideoComments());

    _onTogglePause();
  }

  void _onMuteTap() async {
    _isMuted = !_isMuted;
    _setVideoVolume();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VisibilityDetector(
          key: Key("${widget.index}"),
          onVisibilityChanged: _onVisibilityChanged,
          child: Stack(
            children: [
              Positioned.fill(
                child: _videoPlayerController.value.isInitialized
                    ? VideoPlayer(_videoPlayerController)
                    : (widget.videoData.thumbnailUrl != "")
                        ? Image.network(
                            widget.videoData.thumbnailUrl,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.black,
                          ),
              ),
              Positioned.fill(
                child: GestureDetector(
                  onTap: _onTogglePause,
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animationController.value,
                          child: child,
                        );
                      },
                      child: AnimatedOpacity(
                        opacity: isPaused ? 1 : 0,
                        duration: _animationDuration,
                        child: const FaIcon(
                          FontAwesomeIcons.play,
                          color: Colors.white,
                          size: Sizes.size52,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "@${widget.videoData.creator}",
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.videoData.description,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 20,
                top: 40,
                child: IconButton(
                  onPressed: () {
                    _isMuted = !_isMuted;
                    _setVideoVolume();
                  },
                  icon: FaIcon(
                    _isMuted
                        ? FontAwesomeIcons.volumeOff
                        : FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _onMuteTap,
                      child: _isMuted
                          ? const VideoButton(
                              icon: FontAwesomeIcons.volumeXmark,
                              text: "",
                              color: Colors.white,
                            )
                          : const VideoButton(
                              icon: FontAwesomeIcons.volumeHigh,
                              text: "",
                              color: Colors.white,
                            ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      foregroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/tiktok-pepper-kim.appspot.com/o/avatar%2F${widget.videoData.creatorUid}?alt=media"),
                    ),
                    Gaps.v24,
                    GestureDetector(
                      onTap: () => _onLikeTap(),
                      child: VideoButton(
                        icon: FontAwesomeIcons.solidHeart,
                        color: _isLiked ? Colors.red : Colors.white,
                        text: S.of(context).likeCount(likeCount),
                      ),
                    ),
                    Gaps.v24,
                    GestureDetector(
                      onTap: () => _onCommentTap(context),
                      child: VideoButton(
                        color: Colors.white,
                        icon: FontAwesomeIcons.solidComment,
                        text: S
                            .of(context)
                            .commentCount(widget.videoData.comments),
                      ),
                    ),
                    Gaps.v24,
                    const VideoButton(
                      icon: FontAwesomeIcons.share,
                      text: "Share",
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
