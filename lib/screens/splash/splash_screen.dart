import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;

  bool showLogo = false;

  @override
  void initState() {
    super.initState();

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset(
      'assets/videos/mclaren_intro.mp4',
    );

    await _videoController.initialize();

    await _videoController.play();

    setState(() {});

    /* Future.delayed(_videoController.value.duration, () {
      if (!mounted) return;

      setState(() {
        showLogo = true;
      });

      Future.delayed(const Duration(seconds: 8), () {
        if (mounted) {
          context.go('/dashboard');
        }
      });
    });*/
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showLogo = true;
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        fit: StackFit.expand,
        children: [
          if (!showLogo && _videoController.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            ),

          AnimatedOpacity(
            opacity: showLogo ? 1 : 0,
            duration: const Duration(milliseconds: 1200),

            child: Center(
              child: Image.asset('assets/images/f1_logo.png', width: 260),
            ),
          ),
        ],
      ),
    );
  }
}
