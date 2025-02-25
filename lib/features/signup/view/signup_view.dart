import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/core/shared_preferences/shared_preferences.dart';
import 'package:chat_app/features/signup/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/widgets.dart';
import '../../verification/view/verification_view.dart';
import '../domain/signup_cubit/signup_cubit.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SuccessfullyCreateUserAccountState) {
            Navigator.pop(context);
          }
          if (state is ErrorCreateUserAccountState) {
            print(state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20.h,
                  children: [
                    defaultText(
                      text: "Create an account",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: 20.h,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultTextFormField(
                            hintText: "Name",
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            prefixIcon: Icon(Icons.person_2_outlined),
                          ),
                          defaultTextFormField(
                            hintText: "E-mail",
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          defaultTextFormField(
                            hintText: "Password",
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: SignupCubit.get(context).isPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                SignupCubit.get(
                                  context,
                                ).changePasswordVisibility(password: true);
                              },
                              icon: Icon(
                                SignupCubit.get(context).isPassword
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          defaultTextFormField(
                            hintText: "Confirm Password",
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                SignupCubit.get(context).isConfirmPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                SignupCubit.get(
                                  context,
                                ).changePasswordVisibility(password: false);
                              },
                              icon: Icon(
                                SignupCubit.get(context).isConfirmPassword
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          defaultTextFormField(
                            hintText: "Phone",
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ],
                      ),
                    ),
                    state is! LoadingCreateUserAccountState
                        ? SizedBox(
                          width: double.infinity,
                          child: defaultButton(
                            text: "Create an account",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text.length > 5) {
                                  if (passwordController.text ==
                                      confirmPasswordController.text) {
                                    Constants.userData = {
                                      "name": nameController.text,
                                      "email": emailController.text,
                                      "phone": phoneController.text,
                                      "password" : passwordController.text
                                    };
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => VerificationView(
                                              email: emailController.text, newAccount: true,
                                            ),
                                      ),
                                      (route) => false,
                                    );
                                  } else {
                                    print("Password must be same");
                                  }
                                } else {
                                  print(
                                    "Password must be more than 5 characters",
                                  );
                                }
                              }
                            },
                            color: Colors.green,
                          ),
                        )
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
