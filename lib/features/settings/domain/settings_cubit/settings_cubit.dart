import 'package:bloc/bloc.dart';
import 'package:chat_app/core/shared_preferences/shared_preferences.dart';
import 'package:chat_app/features/signup/data/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  SettingsRepository settingsRepository = SettingsRepository();


UserModel? userModel ;
  Map userModelMap = {};
  Future getSpecificUserDataCubit() async {
    emit(LoadingGetSpecificUserDataState());
    await settingsRepository
        .getSpecificUserDataRepository()
        .then((value) {
          userModel = UserModel.fromJson(value.data());
          userModelMap = userModel!.toMap();
          emit(SuccessfullyGetSpecificUserDataState());
    })
        .catchError((error) {
          emit(ErrorGetSpecificUserDataState(error.toString()));

    });
  }

  void logOut() {
    settingsRepository
        .signOut()
        .then((value) {
          SharedPrefs.removeData(key: "UID");
          emit(SuccessfullyLogOutState());
        })
        .catchError((error) {});
  }

  Future deleteUser() async {
    emit(LoadingDeleteAccountState());
    await settingsRepository
        .deleteUserData()
        .then((value) {
          settingsRepository.deleteAccount().then((value) {
            settingsRepository.signOut();
            SharedPrefs.removeData(key: "UID");
          }).catchError((error){
            emit(ErrorDeleteAccountState(error.toString()));
          });
          emit(SuccessfullyDeleteAccountState());
        })
        .catchError((error) {
          emit(ErrorDeleteAccountState(error.toString()));
    });
  }
}
