import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/upload_video_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;
  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  late final VideoPlayerController _videoPlayerController;
  bool _savedVideo = false;
  String _title = "";
  String _description = "";

  @override
  void initState() {
    super.initState();
    _initVideo();

    _titleController.addListener(() {
      _title = _titleController.text;
      setState(() {});
    });

    _descController.addListener(() {
      _description = _descController.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    await GallerySaver.saveVideo(widget.video.path, albumName: "Tiktok Clone!");

    _savedVideo = true;
    setState(() {});
  }

  void _onUploadPressed() async {
    ref
        .read(uploadVideoProvider.notifier)
        .uploadVideo(File(widget.video.path), _title, _description, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedVideo
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: ref.watch(timelineProvider).isLoading
                ? () {}
                : _onUploadPressed,
            icon: ref.watch(timelineProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(
                    FontAwesomeIcons.cloudArrowUp,
                  ),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? Stack(
              children: [
                VideoPlayer(_videoPlayerController),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Text("      title        : "),
                          title: TextField(
                            minLines: 1,
                            controller: _titleController,
                          ),
                        ),
                        ListTile(
                          leading: const Text("description  : "),
                          title: TextField(
                            minLines: 1,
                            maxLines: 3,
                            controller: _descController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
