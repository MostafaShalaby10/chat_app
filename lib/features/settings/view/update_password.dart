import 'package:chat_app/features/settings/domain/update_cubit/update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/widgets.dart';

class UpdatePassword extends StatelessWidget {
  final bool isEmail;

  const UpdatePassword({super.key, required this.isEmail});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) => UpdateCubit(),
      child: BlocConsumer<UpdateCubit, UpdateState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20,
                children: [
                  if (isEmail)
                    defaultTextFormField(
                      hintText: "Enter the new email",
                      controller: controller,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      prefixIcon: Icon(Icons.email),
                    ),
                  if (!isEmail)
                    defaultTextFormField(
                      hintText: "Enter the password",
                      controller: controller,
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
                        if (isEmail) {
                          UpdateCubit.get(
                            context,
                          ).updateEmail(email: controller.text);
                        } else {
                          UpdateCubit.get(
                            context,
                          ).updatePassword(password: controller.text);
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
