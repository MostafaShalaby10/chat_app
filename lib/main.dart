import 'package:chat_app/features/login/view/login_view.dart';
import 'package:chat_app/features/verification/view/verification_view.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefs.init();
  EmailOTP.config(
    appName: 'Chat App',
    otpType: OTPType.numeric,
    expiry : 60000,
    emailTheme: EmailTheme.v6,
    appEmail: 'work310724@gmail.com',
    otpLength: 6,
  );
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, child) =>
              MaterialApp(debugShowCheckedModeBanner: false, home: LoginView()),
    );
  }
}
