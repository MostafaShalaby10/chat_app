import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/settings_repository.dart';

part 'update_data_state.dart';

class UpdateDataCubit extends Cubit<UpdateDataState> {
  UpdateDataCubit() : super(UpdateDataInitial());

  SettingsRepository settingsRepository = SettingsRepository();
  static UpdateDataCubit get(context) => BlocProvider.of(context);
  Future updateNameAndPhone({
    required String name,
    required String phone,
  }) async {
    emit(LoadingUpdateNameAndPhoneState());
    await settingsRepository
        .updateNameAndPhone(name: name, phone: phone)
        .then((value) {
      emit(SuccessfullyUpdateNameAndPhoneState());
    })
        .catchError((error) {
      emit(ErrorUpdateNameAndPhoneState(error.toString()));
    });
  }

}
