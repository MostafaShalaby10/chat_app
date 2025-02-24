import 'package:chat_app/core/widgets/widgets.dart';
import 'package:chat_app/features/home/view/home_view.dart';
import 'package:chat_app/features/settings/domain/update_data_cubit/update_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateData extends StatelessWidget {
  final String name;
  final String phone;

  const UpdateData({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    nameController.text = name;
    phoneController.text = phone;
    return BlocProvider(
      create: (context) => UpdateDataCubit(),
      child: BlocConsumer<UpdateDataCubit, UpdateDataState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccessfullyUpdateNameAndPhoneState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
              (route) => false,
            );
          }
          if (state is ErrorUpdateNameAndPhoneState) {
            print(state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20.h,
                children: [
                  defaultTextFormField(
                    hintText: "Name",
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    prefixIcon: Icon(Icons.person),
                  ),
                  defaultTextFormField(
                    hintText: "Phone",
                    controller: phoneController,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    prefixIcon: Icon(Icons.phone),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: defaultButton(
                      text: "Update",
                      onPressed: () {
                        UpdateDataCubit.get(context).updateNameAndPhone(
                          phone: phoneController.text,
                          name: nameController.text,
                        );
                      },
                      color: Colors.blueAccent,
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
