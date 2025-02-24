import 'package:chat_app/core/widgets/widgets.dart';
import 'package:chat_app/features/login/view/login_view.dart';
import 'package:chat_app/features/settings/domain/settings_cubit/settings_cubit.dart';
import 'package:chat_app/features/settings/view/update_data.dart';
import 'package:chat_app/features/settings/view/update_password.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..getSpecificUserDataCubit(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccessfullyLogOutState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
              (route) => false,
            );
          }
          if(state is SuccessfullyDeleteAccountState){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: IconButton(
                    onPressed: () {
                      SettingsCubit.get(context).logOut();
                    },
                    icon: Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            body:
                state is! LoadingGetSpecificUserDataState
                    ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          spacing: 20.h,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      spacing: 10.h,
                                      children: [
                                        defaultText(
                                          text:
                                              SettingsCubit.get(
                                                context,
                                              ).userModelMap["name"],
                                          fontSize: 20,
                                        ),
                                        defaultText(
                                          text:
                                              SettingsCubit.get(
                                                context,
                                              ).userModelMap["phone"],
                                          fontSize: 15,
                                        ),
                                        defaultText(
                                          text:
                                              SettingsCubit.get(
                                                context,
                                              ).userModelMap["email"],
                                          fontSize: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (c) => UpdateData(
                                              name:
                                                  SettingsCubit.get(
                                                    context,
                                                  ).userModelMap["name"],
                                              phone:
                                                  SettingsCubit.get(
                                                    context,
                                                  ).userModelMap["phone"],
                                            ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, size: 20),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            UpdatePassword(isEmail: false),
                                  ),
                                );
                              },
                              child: customContainer(text: "Update Password"),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            UpdatePassword(isEmail: true),
                                  ),
                                );
                              },
                              child: customContainer(text: "Update Email"),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                if (await confirm(
                                  context,
                                  title: defaultText(
                                    text: "Warning",
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                  canPop: true,
                                  content: defaultText(
                                    text: "Are you sure to delete Client",
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                )) {
                                  SettingsCubit.get(context).deleteUser();
                                }
                              },
                              child: customContainer(
                                text: "Delete account",
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
