import 'package:chat_app/core/widgets/widgets.dart';
import 'package:chat_app/features/login/view/login_view.dart';
import 'package:chat_app/features/settings/view/update_password.dart';
import 'package:chat_app/features/verification/model/verification_cubit/verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../signup/domain/signup_cubit/signup_cubit.dart';

class VerificationView extends StatelessWidget {
  final String email;
  final bool newAccount;

  const VerificationView({
    super.key,
    required this.email,
    required this.newAccount,
  });

  @override
  Widget build(BuildContext context) {
    SignupCubit signupCubit = SignupCubit();
    return BlocProvider(
      create:
          (context) =>
              VerificationCubit()
                ..emailValidationCubit(email: email) ,
      child: BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if (state is SuccessfullyCheckEmailValidationState) {
            if (newAccount) {
              signupCubit.createUserAccountCubit().then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                  (route) => false,
                );
              });
            } else {
              VerificationCubit.get(context).timer.cancel();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => UpdatePassword()),
                (route) => false,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child:
                      state is! LoadingEmailValidationState
                          ? Column(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultText(
                                text: "Verification",
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                              defaultText(
                                text:
                                    "Enter the code which sent in your E-mail",
                                fontSize: 17,
                              ),
                              defaultText(text: email, fontSize: 14),
                              Pinput(
                                length: 6,
                                defaultPinTheme: PinTheme(
                                  width: 56.w,
                                  height: 56.h,
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(30, 60, 87, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(234, 239, 243, 1),
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onCompleted:
                                    (pin) => VerificationCubit.get(
                                      context,
                                    ).checkEmailValidationCubit(otp: pin),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: defaultText(
                                        text: "Expiration Time",
                                        fontSize: 20,
                                      ),
                                    ),
                                    defaultText(
                                      text:
                                          VerificationCubit.get(
                                            context,
                                          ).start.toString(),
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: defaultButton(
                                  text: "Re-send Code",
                                  onPressed: VerificationCubit.get(context).isExpired?() {
                                    VerificationCubit.get(context).emailValidationCubit(email: email);
                                  }:null,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          )
                          : Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
