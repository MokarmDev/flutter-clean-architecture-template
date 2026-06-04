// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: lib/config/env/.env
final class _Env {
  static const List<int> _enviedkeyapiKey = <int>[
    1650705717,
    2594784546,
    351879475,
    2557959728,
    1187684548,
    3186301021,
  ];

  static const List<int> _envieddataapiKey = <int>[
    1650705668,
    2594784528,
    351879424,
    2557959684,
    1187684593,
    3186301035,
  ];

  static final String apiKey = String.fromCharCodes(List<int>.generate(
    _envieddataapiKey.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]));

  static const List<int> _enviedkeybaseUrl = <int>[
    2113051765,
    2804814395,
    1973538649,
    1348800424,
    3943575309,
    2019457897,
    1037671364,
    2812973039,
    2115569268,
    681325969,
    235444815,
    3854726879,
    776264912,
    1249630078,
    4073156396,
    1892298224,
    2542888465,
    1921129135,
    336761324,
    3438568079,
    312767748,
  ];

  static const List<int> _envieddatabaseUrl = <int>[
    2113051677,
    2804814415,
    1973538605,
    1348800472,
    3943575422,
    2019457875,
    1037671403,
    2812972992,
    2115569168,
    681326052,
    235444770,
    3854726834,
    776264873,
    1249629972,
    4073156447,
    1892298143,
    2542888575,
    1921129089,
    336761231,
    3438568160,
    312767849,
  ];

  static final String baseUrl = String.fromCharCodes(List<int>.generate(
    _envieddatabaseUrl.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddatabaseUrl[i] ^ _enviedkeybaseUrl[i]));
}
