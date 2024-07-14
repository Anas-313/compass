import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/asset_path.dart';
import '../main.dart';

class Compass extends StatelessWidget {
  final qiblaDirection;

  const Compass({super.key, this.qiblaDirection});

  @override
  Widget build(BuildContext context) {
    final qd = qiblaDirection;
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: ((qd.direction * (pi / 180)) * -1),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AssetPath.simpleCompassSvg,
            // color: isVibrating ? Colors.green : Colors.black,
            height: mq.height * .38,
          ),
        ),
        //COMPASS NEEDLE
        Transform.rotate(
          angle: ((qd.qiblah * (pi / 180)) * -1),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AssetPath.needleWithKaaba,
            // color: isVibrating ? Colors.green : Colors.black,
            height: mq.height * .38,
          ),
        ),

        // COMPASS
        // Positioned(
        //   child: Transform.rotate(
        //     angle: ((qd.direction * (pi / 180)) * -1),
        //     alignment: Alignment.center,
        //     child: SvgPicture.asset(
        //       AssetPath.simpleCompassSvg,
        //       // color: isVibrating ? Colors.green : Colors.black,
        //       height: mq.height * .3,
        //     ),
        //   ),
        // ),
        // //COMPASS NEEDLE
        // Positioned(
        //   top: mq.height * .002,
        //   child: Transform.rotate(
        //     angle: ((qd.qiblah * (pi / 180)) * -1),
        //     alignment: Alignment.center,
        //     child: SvgPicture.asset(
        //       AssetPath.compassNeedleSvg,
        //       // color: isVibrating ? Colors.green : Colors.black,
        //       height: mq.height * .3,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
