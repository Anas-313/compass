import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla/utils/qibla_locator.dart';
import 'package:vibration/vibration.dart';

import '../main.dart';
import '../utils/compass.dart';
import '../utils/loading_indicator.dart';

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({super.key});

  @override
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  double currentLatitude = 0.0;
  double currentLongitude = 0.0;
  double qiblaDirection = 0.0;

  // FOR FETCHING CURRENT LOCATION
  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
      });
      if (kDebugMode) {
        print('latitude : $currentLatitude');
        print('longitude : $currentLongitude');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation().then((_) {
      // Calculate Qibla direction once location is obtained
      setState(() {
        qiblaDirection = QiblaLocator.calculateQiblaDirection(
            currentLatitude, currentLongitude);
        if (kDebugMode) {
          print('Qibla direction: $qiblaDirection');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isVibrating = false;

    void vibrateDevice() async {
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 200);
        setState(() {
          isVibrating = true;
        });
        Future.delayed(const Duration(microseconds: 200), () {
          setState(() {
            isVibrating = false;
          });
        });
      }
    }

    return Consumer(builder: (context, ref, child) {
      return StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, AsyncSnapshot<QiblahDirection> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          // ref.read(loadingProvider.notifier).state = false;

          final qiblahDirection = snapshot.data!;

          bool isPointingQibla =
              (qiblahDirection.direction.round() == qiblaDirection.round());
          // Check if the direction is within the threshold of the Qibla direction for vibration
          if (isPointingQibla) {
            vibrateDevice();
          }

          return SafeArea(
            child: Column(
              children: [
                SizedBox(height: mq.height * .04),
                const Text(
                  'Align the arrow with the Kaaba image for accurate Qibla direction.',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'leagueSpartan',
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: mq.height * .15),
                Center(
                  child: Icon(
                    Icons.arrow_upward_outlined,
                    color: isPointingQibla ? Colors.green : Colors.black,
                  ),
                ),
                Compass(
                  qiblaDirection: qiblahDirection,
                ),
                SizedBox(height: mq.height * .05),
                Text(
                  "Direction : ${qiblahDirection.direction.toStringAsFixed(0)}°",
                  style: const TextStyle(
                    fontFamily: 'leagueSpartan',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
