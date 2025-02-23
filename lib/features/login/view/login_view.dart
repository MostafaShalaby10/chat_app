import 'package:chat_app/core/widgets/widgets.dart';
import 'package:chat_app/features/home/view/home_view.dart';
import 'package:chat_app/features/login/domain/login_cubit/login_cubit.dart';
import 'package:chat_app/features/signup/view/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SuccessfullyLoginState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
              (route) => false,
            );
          }
          if (state is ErrorLoginState) {
            print(state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultText(
                      text: "Welcome",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: 30,
                        children: [
                          defaultTextFormField(
                            hintText: "User name",
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          defaultTextFormField(
                            hintText: "Password",
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: LoginCubit.get(context).isPassword,
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                LoginCubit.get(
                                  context,
                                ).changePasswordVisibility();
                              },
                              icon: Icon(
                                LoginCubit.get(context).isPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: defaultText(
                          text: "Reset Password",
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ),

                    state is! LoadingLoginState
                        ? SizedBox(
                          width: double.infinity,
                          child: defaultButton(
                            text: "Login",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).loginCubitFunction(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            color: Colors.blue,
                          ),
                        )
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(
                      width: double.infinity,
                      child: defaultButton(
                        text: "Signup",

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupView(),
                            ),
                          );
                        },
                        color: Colors.green,
                      ),
                    ),
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
