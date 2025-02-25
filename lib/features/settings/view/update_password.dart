import 'package:chat_app/features/settings/domain/update_cubit/update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/widgets.dart';
import '../../login/view/login_view.dart';

class UpdatePassword extends StatelessWidget {

  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => UpdateCubit(),
      child: BlocConsumer<UpdateCubit, UpdateState>(
        listener: (context, state) {
          if (state is SuccessfullyUpdatePasswordState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
              (route) => false,
            );
          }
          },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20,
                children: [
                    defaultTextFormField(
                      hintText: "Enter the password",
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: UpdateCubit.get(context).isPassword,
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          UpdateCubit.get(context).changePasswordVisibility();
                        },
                        icon: Icon(
                          UpdateCubit.get(context).isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: defaultButton(
                      text: "Update",
                      onPressed: () {
                    if(passwordController.text.length>5){
                      UpdateCubit.get(
                        context,
                      ).updatePassword(password: passwordController.text);
                    }
                      },
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
