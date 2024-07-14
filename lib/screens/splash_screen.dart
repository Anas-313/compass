import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/loading_indicator.dart';
import 'device_incompatibility.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        // final isLoading = ref.watch(loadingProvider);
        return Stack(
          children: [
            FutureBuilder(
              future: _deviceSupport,
              builder: (context, AsyncSnapshot<bool?> snapshot) {
                if (kDebugMode) {
                  print('Initial Data: ${snapshot.data}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error.toString()}"),
                  );
                }

                if (snapshot.data!) {
                  // return const QiblaScreen();
                  return const HomeScreen();
                } else {
                  return const DeviceIncompatibility();
                }
              },
            ),
            // if (isLoading)
            //   const Center(
            //     child: CircularProgressIndicator(),
            //   ),
          ],
        );
      },
    );
  }
}

final loadingProvider = StateProvider((ref) => true);
