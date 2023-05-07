import 'package:akc_task_reminder_app/config/app_color.dart';
import 'package:flutter/material.dart';

class BgAuthWidget extends StatelessWidget {
  final Widget child;
  const BgAuthWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: akPrimaryBg,
          ),
          Positioned(
            right: -95,
            top: -70,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 300.0,
                height: 350.0,
                decoration: BoxDecoration(
                  color: akSecondaryBg,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -115,
            top: -50,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 200.0,
                height: 300.0,
                decoration: BoxDecoration(
                  color: akPrimaryBgLight,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -170,
            top: 90,
            child: Transform.rotate(
              angle: 0.6,
              child: Container(
                width: 200.0,
                height: 300.0,
                decoration: BoxDecoration(
                  color: akPrimaryBgLight,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -75,
            top: 310,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 600.0,
                height: 700.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -145,
            top: 325,
            child: Transform.rotate(
              angle: 0.6,
              child: Container(
                width: 600.0,
                height: 700.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: -20,
            child: Transform.rotate(
              angle: -0.4,
              child: const Icon(
                Icons.edit,
                size: 120,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(child: child),
        ],
      ),
    );
  }
}
