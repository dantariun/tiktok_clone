import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFlashButton extends StatelessWidget {
  const CameraFlashButton({
    super.key,
    required this.flashMode,
    required this.toggleMode,
    required this.onPressed,
    required this.icon,
  });

  final FlashMode flashMode;
  final FlashMode toggleMode;
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: flashMode == toggleMode ? Colors.amber.shade200 : Colors.white,
      onPressed: onPressed,
      icon: Icon(
        icon,
      ),
    );
  }
}
