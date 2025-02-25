import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/features/signup/data/repository/signup_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  bool isConfirmPassword = true;
  SignupRepository signupRepository = SignupRepository();

  void changePasswordVisibility({required bool password}) {
    if (password) {
      isPassword = !isPassword;
    } else {
      isConfirmPassword = !isConfirmPassword;
    }
    emit(ChangePasswordVisibility());
  }

  Future createUserAccountCubit() async {
    emit(LoadingCreateUserAccountState());
    print("Start of cubit Function");
    signupRepository
        .signupRepositoryFunction(email: Constants.userData['email'], password: Constants.userData['password'])
        .then((value) {
          signupRepository.saveUserDataRepositoryFunction(
            name: Constants.userData['name'],
            email: Constants.userData['email'],
            phone: Constants.userData['phone'],
            uId: value.user!.uid,
          );
          emit(SuccessfullyCreateUserAccountState());
        })
        .catchError((error) {
          print(error.toString());
          emit(ErrorCreateUserAccountState(error.toString()));
        });
  }


}
