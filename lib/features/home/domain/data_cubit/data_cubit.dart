import 'package:bloc/bloc.dart';
import 'package:chat_app/core/shared_preferences/shared_preferences.dart';
import 'package:chat_app/features/home/data/data_model.dart';
import 'package:chat_app/features/home/data/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'data_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  DataModel? dataModel;

  DataRepository dataRepository = DataRepository();

  List usersData =[];

  Future getAllUsersDataCubitFunction() async {
    emit(LoadingGetAllUsersDataState());
    await dataRepository
        .getAllUsersDataRepositoryFunction()
        .then((value) {
          value.docs.forEach((element) {
            if (element.data()['uid'] != SharedPrefs.getData(key: "UID")) {
              dataModel = DataModel.fromJson(element.data());
              usersData.add(dataModel!.toMap());
            }
          });
          // print(userData);
          emit(SuccessfullyGetAllUsersDataState());
        })
        .catchError((error) {
          emit(ErrorGetAllUsersDataState(error.toString()));
        });
  }
}
