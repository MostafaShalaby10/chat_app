import 'package:bloc/bloc.dart';
import 'package:chat_app/features/login/data/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginRepository loginRepository = LoginRepository();

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibility());
  }

  Future loginCubitFunction({
    required String email,
    required String password,
  }) async {
    emit(LoadingLoginState());
    await loginRepository
        .loginRepositoryFunction(email: email, password: password)
        .then((value) {
          SharedPrefs.saveData(key: "UID", value: value.user!.uid);
          print("idddddddddddddddddddd${SharedPrefs.getData(key: "UID")}");
          emit(SuccessfullyLoginState());
        })
        .catchError((error) {
          emit(ErrorLoginState(error.toString()));
        });
  }
}
