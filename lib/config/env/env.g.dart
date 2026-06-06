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
    45381127,
    2458395783,
    2515161331,
    916909430,
    659759581,
    2614711926,
  ];

  static const List<int> _envieddataapiKey = <int>[
    45381174,
    2458395829,
    2515161280,
    916909378,
    659759592,
    2614711872,
  ];

  static final String apiKey = String.fromCharCodes(List<int>.generate(
    _envieddataapiKey.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]));

  static const List<int> _enviedkeybaseUrl = <int>[
    1377392130,
    3522456295,
    2652243479,
    1170137882,
    2637513807,
    3872295751,
    4231578245,
    1690316928,
    2213089528,
    1780773125,
    2383685526,
    4132839132,
    1241791597,
    2429069510,
    2822331602,
    972181669,
    1694321216,
    767527012,
    210041622,
    1020149219,
    3985951416,
  ];

  static const List<int> _envieddatabaseUrl = <int>[
    1377392234,
    3522456211,
    2652243555,
    1170137962,
    2637513788,
    3872295805,
    4231578282,
    1690316975,
    2213089436,
    1780773232,
    2383685627,
    4132839089,
    1241791508,
    2429069484,
    2822331553,
    972181706,
    1694321198,
    767526986,
    210041717,
    1020149132,
    3985951445,
  ];

  static final String baseUrl = String.fromCharCodes(List<int>.generate(
    _envieddatabaseUrl.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddatabaseUrl[i] ^ _enviedkeybaseUrl[i]));
}
