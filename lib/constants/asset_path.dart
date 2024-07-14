import 'package:flutter_svg/svg.dart';

class AssetPath {
  static const compassSvg = 'assets/images/compass.svg';
  static const compass_1 = 'assets/images/compass-1.svg';
  static const qiblaDirection = 'assets/images/qibla_direction.png';
  static const kaaba = 'assets/images/kaaba-svg.svg';
  static const needle = 'assets/images/needle.svg';
  static const kaabaNeedleSvg = 'assets/images/kaaba-needle.svg';

  static const simpleCompassSvg = 'assets/images/simple-compass.svg';
  static const compassNeedleSvg = 'assets/images/compass-needle.svg';
  static const simpleCompassSvg_3 = 'assets/images/compass-3.svg';
  static const simpleCompassSvg_4 = 'assets/images/compass-4.svg';

  static const needleWithKaaba = 'assets/images/needle-with-kaaba.svg';
  static const needleWithKaaba_2 = 'assets/images/needle-with-kaaba-2.svg';
  static const needleWithKaaba_3 = 'assets/images/3.svg';
  static const needleWithKaaba_4 = 'assets/images/4.svg';
  static const needleWithKaaba_5 = 'assets/images/5.svg';
  static const needleWithKaaba_6 = 'assets/images/6.svg';
  static const needleWithKaaba_7 = 'assets/images/7.svg';
  static const needleWithKaaba_8 = 'assets/images/8.svg';
  static const needleWithKaaba_9 = 'assets/images/9.svg';
  static const needleWithKaaba_10 = 'assets/images/10.svg';

  final needleSvg = SvgPicture.asset(
    'assets/images/needle.svg',
    height: 250,
    width: 50,
  );
  final compass = SvgPicture.asset(
    'assets/images/compass.svg',
    height: 250,
    width: 50,
  );
  final kaabaSvg = SvgPicture.asset(
    'assets/images/kaaba-svg.svg',
    height: 250,
    width: 50,
  );
}
