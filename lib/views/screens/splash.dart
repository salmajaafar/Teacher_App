import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_app/controllers/splashController.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/widget/AppName.dart';
import 'package:parent_app/views/widget/PositionedBlob.dart';
import 'package:parent_app/views/widget/logo.dart';
import 'package:parent_app/views/widget/drawCircle.dart';


class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    
   Get.put(SplashController());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
     Get.delete<SplashController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.Color1,
      body: Stack(
        children: [

         
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: AdvancedCreativePainter(),
                ),
              );
            },
          ),

          ..._buildFloatingBlobs(),

         
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TweenAnimationBuilder(
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 0.8, end: 1.0),
                  builder: (context, double val, child) =>
                      Transform.scale(
                        scale: val,
                        child: Logo(),
                      ),
                ),

                const SizedBox(height: 30),
                nameApp(),
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Helping you rise, guide, and grow with confidence.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'KiwiMaru',
                      fontSize: 14,
                      color: ColorsApp.PraimaryMain.withOpacity(0.8),
                    ),
                  ),
                ),

                const SizedBox(height: 70),

                Container(
                  width: 200,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsApp.PraimaryMain.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      color: ColorsApp.PraimaryMain,
                      backgroundColor: Colors.transparent,
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

  List<Widget> _buildFloatingBlobs() {
    return [
      PositionedBlob(top: 100, left: -50, size: 150, delay: 0),
      PositionedBlob(bottom: 150, right: -70, size: 200, delay: 500),
      PositionedBlob(top: 400, right: 20, size: 80, delay: 1000),
    ];
  }
}

