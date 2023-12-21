import 'package:flutter/material.dart';

// class VideoConfig extends ChangeNotifier {
//   bool autoMute = true;

//   void toggleAutoMute() {
//     autoMute = !autoMute;
//     notifyListeners();
//   }
// }

// final videoConfig = VideoConfig();

// final videoConfig = ValueNotifier(false);

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
