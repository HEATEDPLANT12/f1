import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;

  bool isInitialized = false;

  bool showLogo = false;
  bool fadeVideo = false;
  bool fadeLogoOut = false;

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

    setState(() {
      isInitialized = true;
    });

    await _videoController.play();

    final duration = _videoController.value.duration;

    // Start logo reveal + video fade
    Future.delayed(duration - const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      setState(() {
        showLogo = true;
        fadeVideo = true;
      });
    });

    // Fade logo out after video has ended
    Future.delayed(duration + const Duration(milliseconds: 800), () {
      if (!mounted) return;

      setState(() {
        fadeLogoOut = true;
      });
    });

    // Navigate to dashboard
    Future.delayed(duration + const Duration(milliseconds: 2200), () {
      if (!mounted) return;

      context.go('/team_selection');
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
      body: !isInitialized
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Stack(
              fit: StackFit.expand,
              children: [
                // VIDEO
                AnimatedOpacity(
                  opacity: fadeVideo ? 0 : 1,
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.easeInOut,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                ),

                // BLACK OVERLAY
                AnimatedOpacity(
                  opacity: fadeVideo ? 1 : 0,
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.easeInOut,
                  child: Container(color: Colors.black),
                ),

                // LOGO
                AnimatedOpacity(
                  opacity: !showLogo
                      ? 0
                      : fadeLogoOut
                      ? 0
                      : 1,
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeInOut,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/f1_logo.svg',
                      width: 260,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
