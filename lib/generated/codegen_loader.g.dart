// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "app_name": "سامان",
  "authentication": {
    "login": "تسجيل الدخول",
    "register": "تسجيل حساب جديد",
    "forgot_password": "نسيت كلمة المرور",
    "reset_password": "إعادة تعيين كلمة المرور",
    "verify_code": "التحقق من الرمز",
    "phone_number": "رقم الهاتف",
    "password": "كلمة المرور",
    "confirm_password": "تأكيد كلمة المرور",
    "code": "الرمز",
    "send_code": "إرسال الرمز",
    "verify": "تحقق",
    "login_with_phone": "تسجيل الدخول برقم الهاتف",
    "login_with_email": "تسجيل الدخول بالبريد الإلكتروني",
    "login_with_google": "تسجيل الدخول باستخدام جوجل",
    "login_with_facebook": "تسجيل الدخول باستخدام فيسبوك",
    "login_with_apple": "تسجيل الدخول باستخدام آبل"
  },
  "navigation": {
    "home": "الرئيسية",
    "cart": "السلة",
    "profile": "الملف الشخصي"
  }
};
static const Map<String,dynamic> _en = {
  "app_name": "Saman",
  "authentication": {
    "login": "Login",
    "register": "Register",
    "forgot_password": "Forgot Password",
    "reset_password": "Reset Password",
    "verify_code": "Verify Code",
    "phone_number": "Phone Number",
    "password": "Password",
    "confirm_password": "Confirm Password",
    "code": "Code",
    "send_code": "Send Code",
    "verify": "Verify",
    "login_with_phone": "Login with Phone",
    "login_with_email": "Login with Email",
    "login_with_google": "Login with Google",
    "login_with_facebook": "Login with Facebook",
    "login_with_apple": "Login with Apple"
  },
  "navigation": {
    "home": "Home",
    "cart": "Cart",
    "profile": "Profile"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
