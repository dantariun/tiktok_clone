// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:flutter/foundation.dart';

import 'video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );

  late final AnimationController _progressAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        lowerBound: 0.0,
        upperBound: 1.0,
      );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;
  late double _minZoom;
  late double currentPosition;

  late FlashMode _flashMode;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording(); // only ios
    _flashMode = _cameraController.value.flashMode;
    _minZoom = await _cameraController.getMinZoomLevel();
    setState(() {});
  }

  Future<void> initPermission() async {
    print("kIsWeb $kIsWeb");
    if (kIsWeb) {
      // await window.navigator.getUserMedia(audio: true, video: true).then(
      //   (value) {
      //     _hasPermission = true;
      //     initCamera();
      //   },
      // );
    } else {
      final camearaPermission = await Permission.camera.request();
      final micPermission = await Permission.microphone.request();
      final cameraDenied =
          camearaPermission.isDenied || camearaPermission.isPermanentlyDenied;
      final micDenied =
          micPermission.isDenied || micPermission.isPermanentlyDenied;

      if (!cameraDenied && !micDenied) {
        _hasPermission = true;
        initCamera();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermission();
    } else {
      _hasPermission = true;
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails details) async {
    currentPosition = details.globalPosition.dy;
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: video, isPicked: false),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) _cameraController.dispose();
    super.dispose();
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: video, isPicked: true),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> _onVerticalDragUpdate(DragUpdateDetails details) async {
    double distance = currentPosition - details.globalPosition.dy;
    await _cameraController.setZoomLevel(distance / 200 + _minZoom);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          !_hasPermission
              ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Initializing...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size18,
                      ),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              )
              : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  const Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,
                    child: CloseButton(color: Colors.white),
                  ),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size40,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(Icons.cameraswitch),
                          ),
                          IconButton(
                            color:
                                _flashMode == FlashMode.off
                                    ? Colors.amber.shade200
                                    : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.off),
                            icon: const Icon(Icons.flash_off_rounded),
                          ),
                          IconButton(
                            color:
                                _flashMode == FlashMode.always
                                    ? Colors.amber.shade200
                                    : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.always),
                            icon: const Icon(Icons.flash_on_rounded),
                          ),
                          IconButton(
                            color:
                                _flashMode == FlashMode.auto
                                    ? Colors.amber.shade200
                                    : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.auto),
                            icon: const Icon(Icons.flash_auto_rounded),
                          ),
                          IconButton(
                            color:
                                _flashMode == FlashMode.torch
                                    ? Colors.amber.shade200
                                    : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.torch),
                            icon: const Icon(Icons.flashlight_on_rounded),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          // onPanUpdate: _changeCameraZoom,
                          onVerticalDragUpdate: _onVerticalDragUpdate,
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording,
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
