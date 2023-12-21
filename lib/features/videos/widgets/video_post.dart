import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widget/video_configuration/video_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/video/FastForwardChallenge.mp4");

  final Duration _animationDuration = const Duration(milliseconds: 200);
  bool isPaused = false;
  bool isMuted = false;

  final String desc = "#JEONSOMI x #JIHYO #TWICE #FastForwardChallenge";

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    if (kIsWeb) {
      isMuted = true;
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChanged);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
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
      _videoPlayerController.play();
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
    isMuted = !isMuted;
    if (isMuted) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(1);
    }
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
              const Positioned(
                left: 10,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "@Pepper",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "FastForwardChallenge",
                      style: TextStyle(
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
                    context.read<VideoConfig>().toggleIsMuted();
                  },
                  icon: FaIcon(
                    context.watch<VideoConfig>().isMuted
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
                      child: isMuted
                          ? const VideoButton(
                              icon: FontAwesomeIcons.volumeXmark,
                              text: "",
                            )
                          : const VideoButton(
                              icon: FontAwesomeIcons.volumeHigh,
                              text: "",
                            ),
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                    ),
                    Gaps.v24,
                    VideoButton(
                      icon: FontAwesomeIcons.solidHeart,
                      text: S.of(context).likeCount(20398),
                    ),
                    Gaps.v24,
                    GestureDetector(
                      onTap: () => _onCommentTap(context),
                      child: VideoButton(
                        icon: FontAwesomeIcons.solidComment,
                        text: S.of(context).commentCount(098345871231234),
                      ),
                    ),
                    Gaps.v24,
                    const VideoButton(
                      icon: FontAwesomeIcons.share,
                      text: "Share",
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
