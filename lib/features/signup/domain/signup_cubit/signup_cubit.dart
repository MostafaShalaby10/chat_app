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

  Future createUserAccountCubit({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(LoadingCreateUserAccountState());
    print("Start of cubit Function");
     signupRepository
        .signupRepositoryFunction(email: email, password: password)
        .then((value)  {

           signupRepository.saveUserDataRepositoryFunction(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid,
          );
          emit(SuccessfullyCreateUserAccountState());
        })
        .catchError((error) {
          emit(ErrorCreateUserAccountState(error.toString()));
        });
  }
}
