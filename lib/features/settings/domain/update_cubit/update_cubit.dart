import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/settings_repository.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitial());
  static UpdateCubit get(context) => BlocProvider.of(context);

  SettingsRepository settingsRepository = SettingsRepository();



  Future updateEmail({required String email}) async {
    emit(LoadingUpdateEmailState());
    await settingsRepository
        .updateEmail(email: email)
        .then((value) {
      emit(SuccessfullyUpdateEmailState());
    })
        .catchError((error) {
      emit(ErrorUpdateEmailState(error.toString()));
    });
  }

  Future updatePassword({required String password}) async {
    emit(LoadingUpdatePasswordState());
    await settingsRepository
        .updatePassword(password: password)
        .then((value) {
      emit(SuccessfullyUpdatePasswordState());
    })
        .catchError((error) {
      emit(ErrorUpdatePasswordState(error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

}
